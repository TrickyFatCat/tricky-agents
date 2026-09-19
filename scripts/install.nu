#!/usr/bin/env nu

# Install this repository's global rules and skills for every agent tool.
#
#   nu scripts/install.nu                 every tool, rules and all skills
#   nu scripts/install.nu --tool claude   one tool
#   nu scripts/install.nu --skill combat  one skill, no rules file
#
# Nothing is copied. Each install is a symlink into this repository, so editing
# a file here changes what the tools read, with no second step.
#
# Skills are linked one folder at a time. A tool's skills directory usually
# holds folders from elsewhere, and linking the directory itself would hide
# them.
#
# Nothing is replaced or deleted. A path already in use is reported and
# skipped; repairing it is left to you.
#
# Supporting another tool is one new row in `tool-targets` below.

# ~/... for anything under the home directory, unchanged otherwise.
def tilde [path: string] {
    try {
        $"~/($path | path relative-to $nu.home-dir)"
    } catch { $path }
}

# "file", "dir", "symlink", or "" when nothing is there. A symlink is reported
# as a symlink, never followed.
#
# The `default` is not cosmetic: `path type` declares a string output but yields
# nothing for a missing path, and `let` refuses that mismatch.
def path-kind [path: string] {
    $path | path type | default ""
}

# Every tool this script installs for.
#
# To support another tool, add a row: the name you will pass to --tool, its
# config directory under home, and the name its rules file must take. Nothing
# else in the script needs to change.
def tool-targets [] {
    [
        [tool       dir         rules_file];
        ["agents"   ".agents"   "AGENTS.md"]
        ["claude"   ".claude"   "CLAUDE.md"]
        ["codex"    ".codex"    "AGENTS.md"]
    ]
    | each {|r| {
        tool: $r.tool
        rules: ($nu.home-dir | path join $r.dir $r.rules_file)
        skills: ($nu.home-dir | path join $r.dir "skills")
    }}
}

# The path a symlink points at, read from the parent directory's listing.
#
# Listing the link itself would follow it: for a link to a directory, `ls`
# returns the contents. The parent listing also still reports a dead link.
def link-target [link: string] {
    ls --long ($link | path dirname)
    | where name == $link
    | get 0.target
}

# What is at a target path, as {state, kind, target}.
#
#   missing    nothing there                       create it
#   linked     symlink already pointing at source  leave it, already done
#   foreign    symlink pointing somewhere else     leave it, blocked
#   occupied   a real file or directory            leave it, blocked
#
# The caller gets the kind and the link target too, so it never has to look the
# same path up twice and risk describing a row it did not classify.
#
# `path exists` is no use here: it follows links, so a dead symlink reports
# false and would look like free space.
def classify [link: string, source: string] {
    let kind = path-kind $link

    if ($kind | is-empty) {
        return {state: "missing", kind: $kind, target: null}
    }

    if $kind != "symlink" {
        return {state: "occupied", kind: $kind, target: null}
    }

    let target = link-target $link

    {
        state: (if $target == $source { "linked" } else { "foreign" })
        kind: $kind
        target: $target
    }
}

# The repository's skills, as {name, source}.
#
# A folder under skills/ counts only when it holds a SKILL.md, so notes and
# half-finished directories are never installed.
def repo-skills [root: string] {
    let dir = $root | path join "skills"

    if (path-kind $dir) != "dir" {
        return []
    }

    ls $dir
    | where type in ["dir" "symlink"]
    | where {|row| (path-kind ($row.name | path join "SKILL.md")) == "file" }
    | each {|row| {name: ($row.name | path basename), source: $row.name} }
    | sort-by name
}

# The word and colour each state is reported with.
#
# Both blocked states say "blocked" but differ in colour, because they differ in
# risk. A foreign symlink is yellow: deleting it loses nothing. A real file is
# red: it may hold the only copy of what is in it.
#
# Nushell drops these colours when the output is piped, so redirected text stays
# clean.
def state-style [state: string] {
    match $state {
        "missing" => {action: "created", colour: "green"}
        "linked"  => {action: "ok",      colour: "dark_gray"}
        "foreign" => {action: "blocked", colour: "yellow"}
        _         => {action: "blocked", colour: "red"}
    }
}

# Abort, listing the values that would have worked.
def unknown [what: string, given: string, known: list<string>, hint: string] {
    let listed = if ($known | is-empty) {
        $"  (ansi red)none found(ansi reset)"
    } else {
        $known | each {|k| $"  (ansi green)($k)(ansi reset)" } | str join "\n"
    }

    error make --unspanned {
        msg: $"unknown ($what) '($given)'"
        help: $"Known ($what)s:\n\n($listed)\n\n($hint)"
    }
}

# Warn when a hand-edited source is newer than the generated file the links
# point at. Never fails the run: the links work, they just serve old text.
def warn-if-stale [root: string, out: string] {
    if (path-kind $out | is-empty) {
        return
    }

    let out_time = ls $out | get 0.modified

    let newer = (
        ["global/machine-rules.md" "global/personal-rules.md"]
        | where {|rel|
            let src = $root | path join $rel
            (path-kind $src | is-not-empty) and ((ls $src | get 0.modified) > $out_time)
        }
    )

    if ($newer | is-empty) {
        return
    }

    let out_label = try { $out | path relative-to $root } catch { $out }

    print $"(ansi yellow)Warning(ansi reset): newer than ($out_label): ($newer | str join ', ')"
    print $"Rebuild with (ansi blue)nu scripts/build-global-agents.nu(ansi reset), or the links serve stale text.\n"
}

# Everything, or the one row named. An unrecognised name aborts.
def pick-tools [all: list<any>, wanted: string] {
    if ($wanted | is-empty) {
        return $all
    }

    let hit = $all | where tool == $wanted

    if ($hit | is-empty) {
        unknown "tool" $wanted ($all | get tool) "Add a row to tool-targets to support another tool."
    }

    $hit
}

# Everything, or the one skill named. An unrecognised name aborts.
def pick-skills [all: list<any>, wanted: string] {
    if ($wanted | is-empty) {
        return $all
    }

    let hit = $all | where name == $wanted

    if ($hit | is-empty) {
        unknown "skill" $wanted ($all | get name) "A skill is a folder in skills/ holding a SKILL.md."
    }

    $hit
}

# One row per link to make: for each tool, the rules file then each skill.
def build-work [
    tools: list<any>
    skills: list<any>
    rules_source: string
    with_rules: bool
] {
    $tools
    | each {|t|
        let rules_entry = if $with_rules {
            [{
                tool: $t.tool
                item: ($t.rules | path basename)
                link: $t.rules
                source: $rules_source
            }]
        } else { [] }

        let skill_entries = $skills | each {|s| {
            tool: $t.tool
            item: $"skills/($s.name)"
            link: ($t.skills | path join $s.name)
            source: $s.source
        }}

        $rules_entry | append $skill_entries
    }
    | flatten
}

# Make every missing link, and return one report row per entry.
def install-all [work: list<any>] {
    $work | each {|e|
        let found = classify $e.link $e.source

        let reason = match $found.state {
            "missing" => (tilde $e.link)
            "linked"  => "already linked"
            "foreign" => $"links to (tilde $found.target)"
            _         => $"a ($found.kind) is already there"
        }

        if $found.state == "missing" {
            mkdir ($e.link | path dirname)
            ^ln -s $e.source $e.link   # Nushell has no symlink builtin.
        }

        let style = state-style $found.state

        {
            tool: $e.tool
            item: $e.item
            action: $"(ansi $style.colour)($style.action)(ansi reset)"
            reason: $reason
        }
    }
}

def main [
    --tool: string    # install for one tool only; default is every row
    --skill: string   # install one skill only; skips the rules file
] {
    # From the script's own location, so any working directory works.
    let root = $env.FILE_PWD | path join ".." | path expand
    let rules_source = $root | path join "global" "global-agents.md"
    let with_rules = ($skill | is-empty)

    let tools = pick-tools (tool-targets) ($tool | default "")
    let skills = pick-skills (repo-skills $root) ($skill | default "")

    # A --skill run never touches the rules file, so it need not exist.
    if $with_rules {
        if (path-kind $rules_source | is-empty) {
            error make --unspanned {
                msg: "missing global/global-agents.md"
                help: $"That file is generated. Build it with (ansi blue)nu scripts/build-global-agents.nu(ansi reset) and run this again."
            }
        }

        warn-if-stale $root $rules_source
    }

    let work = build-work $tools $skills $rules_source $with_rules

    if ($work | is-empty) {
        print "Nothing to install. Add a skill folder under skills/, or drop --skill."
        return
    }

    install-all $work
}
