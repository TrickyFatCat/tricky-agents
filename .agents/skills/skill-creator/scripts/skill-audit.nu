#!/usr/bin/env nu

# Read-only skill audit helper for skill-creator evaluation.
# No writes, no network, no package dependencies.

def display-path [p: string]: nothing -> string {
  $p | path expand | str replace $nu.home-dir "~"
}

def excluded? [name: string, exclude: string]: nothing -> bool {
  $exclude
  | split row ","
  | each { |it| $it | str trim }
  | where { |it| not ($it | is-empty) }
  | any { |it| $it == $name }
}

def require-dir [root: path, purpose: string]: nothing -> string {
  let expanded = ($root | path expand)
  if not ($expanded | path exists) {
    error make { msg: $"($purpose) does not exist: (display-path $expanded)" }
  }
  if (($expanded | path type) != "dir") {
    error make { msg: $"($purpose) is not a directory: (display-path $expanded)" }
  }
  $expanded
}

def markdown-files [root: path]: nothing -> list<string> {
  let checked_root = (require-dir $root "skill directory")
  let pattern = ($checked_root | path join "**/*.md")
  glob $pattern
}

def skill-files [root: path, exclude: string]: nothing -> list<string> {
  let checked_root = (require-dir $root "skills root")
  let pattern = ($checked_root | path join "*/SKILL.md")
  glob $pattern
  | where { |p|
      let name = ($p | path dirname | path basename)
      not (excluded? $name $exclude)
    }
}

def frontmatter [text: string]: nothing -> record {
  let parts = ($text | split row "---")
  if ($parts | length) < 3 {
    {}
  } else {
    try { $parts.1 | from yaml } catch { {} }
  }
}

def strip-fenced-blocks []: string -> string {
  let text = $in
  $text
  | lines
  | reduce --fold { fence_marker: "", out: [] } { |line, acc|
      let trimmed = ($line | str trim)
      let marker = if ($trimmed | str starts-with "```") {
        "```"
      } else if ($trimmed | str starts-with "~~~") {
        "~~~"
      } else {
        ""
      }
      if ($acc.fence_marker | is-empty) {
        if ($marker | is-empty) {
          { fence_marker: $acc.fence_marker, out: ($acc.out | append $line) }
        } else {
          { fence_marker: $marker, out: $acc.out }
        }
      } else if $marker == $acc.fence_marker {
        { fence_marker: "", out: $acc.out }
      } else {
        $acc
      }
    }
  | get out
  | str join "\n"
}

def inventory [root: path, exclude: string]: nothing -> record {
  let rows = (
    skill-files $root $exclude
    | each { |p|
        let txt = (open --raw $p)
        let fm = (frontmatter $txt)
        let skill_dir = ($p | path dirname)
        let dir_name = ($skill_dir | path basename)
        let refs = (glob ($skill_dir | path join "references/*.md"))
        let scripts = ((glob ($skill_dir | path join "scripts/*")) ++ (glob ($skill_dir | path join "script/*")))
        let assets = (glob ($skill_dir | path join "assets/*"))
        let lines = ($txt | lines | length)
        let heading_count = ($txt | lines | where { |line| $line =~ "^#{1,3} " } | length)
        let description = ($fm.description? | default "")
        {
          skill: $dir_name,
          name: ($fm.name? | default null),
          name_matches_dir: (($fm.name? | default "") == $dir_name),
          description_length: ($description | str length),
          description_starts_with_use: ($description | str starts-with "Use"),
          description_has_when: ($description | str lowercase | str contains "when"),
          skill_md_lines: $lines,
          over_500_lines: ($lines > 500),
          headings: $heading_count,
          references: ($refs | length),
          scripts: ($scripts | length),
          assets: ($assets | length),
          path: (display-path $p)
        }
      }
    | sort-by skill
  )
  {
    schema_version: 1,
    tool: "skill-audit",
    command: "inventory",
    status: (if (($rows | length) == 0) { "failed" } else { "ok" }),
    summary: $"($rows | length) skills inventoried",
    counts: {
      skills: ($rows | length),
      name_mismatches: ($rows | where name_matches_dir == false | length),
      missing_descriptions: ($rows | where description_length == 0 | length),
      long_descriptions: ($rows | where description_length > 1024 | length),
      non_imperative_descriptions: ($rows | where description_starts_with_use == false | length),
      descriptions_without_when: ($rows | where description_has_when == false | length),
      over_500_line_skills: ($rows | where over_500_lines == true | length)
    },
    items: $rows
  }
}

def local-links [root: path]: nothing -> record {
  let files = (markdown-files $root)
  let findings = (
    $files
    | each { |file|
        let dir = ($file | path dirname)
        let text = (open --raw $file | strip-fenced-blocks)
        $text
        | parse --regex "\\[[^\\]]+\\]\\((?<target>[^)]+)\\)"
        | where { |m|
            let target = ($m.target | str trim)
            let clean = ($target | split row "#" | get 0)
            let is_external = (($target | str starts-with "http://") or ($target | str starts-with "https://") or ($target | str starts-with "mailto:") or ($target | str starts-with "#") or ($target | str starts-with "/"))
            (not ($clean | is-empty)) and (not $is_external)
          }
        | each { |m|
            let target = ($m.target | str trim)
            let clean = ($target | split row "#" | get 0)
            let resolved = ($dir | path join $clean)
            let exists = ($resolved | path exists)
            {
              status: (if $exists { "ok" } else { "missing" }),
              file: (display-path $file),
              target: $target,
              resolved: (display-path $resolved)
            }
          }
      }
    | flatten
    | sort-by status file target
  )
  let missing = ($findings | where status == "missing")
  {
    schema_version: 1,
    tool: "skill-audit",
    command: "links",
    status: (if (($missing | length) > 0) { "failed" } else if (($files | length) == 0) { "failed" } else { "ok" }),
    summary: (if (($files | length) == 0) { "no Markdown files found" } else { $"($findings | length) local links checked, ($missing | length) missing" }),
    counts: {
      markdown_files: ($files | length),
      links: ($findings | length),
      missing: ($missing | length)
    },
    items: $findings
  }
}

def emit [format: string]: record -> any {
  let data = $in
  match $format {
    "json" => ($data | to json --indent 2),
    "table" => ($data.items),
    _ => (error make { msg: "--format must be json or table" })
  }
}

def main [
  command: string # inventory | links
  root: path # skills root for inventory; one skill directory for links
  --exclude: string = "" # comma-separated skill directories to skip
  --format: string = "json" # json | table
]: nothing -> any {
  match $command {
    "inventory" => (inventory $root $exclude | emit $format),
    "links" => (local-links $root | emit $format),
    _ => (error make { msg: "command must be inventory or links" })
  }
}
