#!/usr/bin/env nu

# Installs this repository's global rules and skills for every agent tool.
#
# Links instead of copying, so an edit here reaches the tools with no second step.
#
# Never replaces or deletes anything.
# Reports and skips a path already in use, and leaves the repair to you.

# Prints a refusal to stderr and exits with code 2.
# A refusal means a safety rule declined a valid request, and nothing is malformed.
def refuse [msg: string, detail: string] {
    # Prints plain text, not an error box, so a refusal does not read as an error.
    print -e $"(ansi red)Refused(ansi reset): ($msg)\n"
    print -e $detail
    exit 2
}

# Exits with code 2 unless root is the primary checkout.
# Returns without a check when root is not a git checkout.
#
# Links point at the checkout this script runs from.
# A link made in a worktree dies when worktree-cleanup.nu deletes that worktree.
def check-primary-checkout [root: string] {
    let dir = ^git -C $root rev-parse --git-dir | complete
    let common = ^git -C $root rev-parse --git-common-dir | complete

    if $dir.exit_code != 0 or $common.exit_code != 0 {
        return   # Not a git checkout, so it cannot be a worktree.
    }

    let here = $root | path join ($dir.stdout | str trim) | path expand --no-symlink
    let shared = $root | path join ($common.stdout | str trim) | path expand --no-symlink

    if $here == $shared {
        return
    }

    refuse "not the primary checkout" $"  (ansi red)($root)(ansi reset)  is a worktree\n\nA link made here dies when the worktree is removed. Run install from the primary checkout:\n\n  (ansi green)($shared | path dirname)(ansi reset)"
}

# Returns the path as ~/... when it is under the home directory, and unchanged otherwise.
def tilde [path: string] {
    try {
        $"~/($path | path relative-to $nu.home-dir)"
    } catch { $path }
}

# "file", "dir", "symlink", or "" when nothing is there.
# Never follows a symlink.
def path-kind [path: string] {
    # Keep the `default`, because without it `let` fails on a missing path.
    $path | path type | default ""
}

# Returns {tool, rules, skills}, with rules and skills as full paths.
#
# To support another tool, add a row here and change nothing else.
# `tool` is the name passed to --tool.
# `dir` is the tool's config directory under home.
# `rules_file` is the file name the tool reads its rules from.
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

# Returns the path a symlink stores, without following it.
def link-target [link: string] {
    # Lists the parent, so a link to a directory or a dead link still gives its own row.
    ls --long ($link | path dirname)
    | where name == $link
    | get 0.target
}

# Returns what is at link, as {state, kind, target}.
#
#   missing    nothing there                       create it
#   linked     symlink already pointing at source  leave it, already done
#   foreign    symlink pointing somewhere else     leave it, blocked
#   occupied   a real file or directory            leave it, blocked
#
# Returns kind and target too, so the caller never reads the path twice.
# A second read could report a different state than the one classified.
def classify [link: string, source: string] {
    # Uses path-kind, not `path exists`, so a dead symlink is not taken for free space.
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

# Returns the repository's skills as {name, source}, sorted by name.
# Returns an empty list when skills/ is missing.
# Skips a folder without a SKILL.md, so notes and unfinished folders are never installed.
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

# Returns the action word and colour for a state.
#
# Both blocked states say "blocked", and the colour shows the risk.
# Yellow marks a foreign symlink, which loses nothing when deleted.
# Red marks a real file or directory, which may hold the only copy of its content.
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

# Aborts with an error that lists the known values, then the hint.
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

# Prints a warning when machine-rules.md or personal-rules.md is newer than out.
# Never fails the run, because stale links still work and only serve old text.
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

# Returns every row when wanted is empty, or else the one row named.
# Aborts on an unknown name.
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

# Returns every skill when wanted is empty, or else the one skill named.
# Aborts on an unknown name.
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

# Returns one row per link, with each tool's rules file first and then its skills.
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

        # Links each skill folder, not the skills directory, so skills from elsewhere stay visible.
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

# Creates each missing link and its parent directories.
# Returns one report row per entry.
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
            ^ln -s $e.source $e.link
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
    --tool: string    # install for this tool only, not every tool
    --skill: string   # install this skill only, without the rules file
] {
    # Resolves root from the script's location, so the script runs from any directory.
    let root = $env.FILE_PWD | path join ".." | path expand
    check-primary-checkout $root

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

    let report = install-all $work

    # Prints the skill name as a heading instead of an item column that repeats it on every row.
    if ($skill | is-empty) {
        print $report
    } else {
        print $"($skill)\n"
        print ($report | reject item)
    }

    # Exits 3 when any row is blocked, because the run did less than asked but did not fail.
    if ($report | any {|r| ($r.action | ansi strip) == "blocked" }) {
        exit 3
    }
}
