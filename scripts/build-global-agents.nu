#!/usr/bin/env nu

# Merges the two rule sources into one generated agent file.

# Prints a refusal to stderr and exits with code 2.
#
# A refusal is not an error.
# The sources are readable and the flags are valid.
# The build declines because it cannot produce a correct file.
def refuse [msg: string, detail: string] {
    # Prints plain text, not an error box, so a refusal does not read as an error.
    print -e $"(ansi red)Refused(ansi reset): ($msg)\n"
    print -e $detail
    exit 2
}

# Returns the path relative to root when it sits under root, and unchanged otherwise.
def relative-or-absolute [path: string, root: string] {
    try {
        $path | path relative-to $root
    } catch { $path }
}

# Returns every line as {line, text, fenced}, with line counted from 1.
# The ``` lines count as fenced too, so a fence line is never read as content.
# Only ``` opens or closes a fence, so a ~~~ fence is read as content.
#
# demote-headings and collect-headings both call this.
# Two copies of the fence tracking would drift apart.
def tag-fences [text: string] {
    mut fenced = false
    mut out = []

    for entry in ($text | lines | enumerate) {
        let is_fence = (($entry.item | str trim) | str starts-with "```")

        if $is_fence {
            $fenced = (not $fenced)
        }

        $out = ($out | append {
            line: ($entry.index + 1)
            text: $entry.item
            fenced: ($fenced or $is_fence)
        })
    }

    $out
}

# Drops every heading outside a fence one level.
# Counts a line as a heading only when whitespace follows the hashes, so `#hashtag` is left alone.
# Gives a level-six heading seven hashes, so callers run check-max-level first.
def demote-headings [text: string] {
    tag-fences $text
    | each {|l|
        if (not $l.fenced) and ($l.text =~ '^#{1,6}\s') {
            $"#($l.text)"
        } else {
            $l.text
        }
    }
    | str join "\n"
}

# Returns the form the clash check compares.
# The output never contains this form.
# Two headings that differ only in case, spacing, emphasis, code marks, closing hashes or trailing punctuation count as the same name.
def normalise-heading [text: string] {
    $text
    | str replace --all --regex '\s+#+\s*$' ''
    | str replace --all --regex '[`*_]' ''
    | str replace --all --regex '[.,:;!?]+$' ''
    | str lowercase
    | str replace --all --regex '\s+' ' '
    | str trim
}

# Returns every heading outside a fence as {file, line, level, raw, text}, with line counted from 1.
# file is the label, which refusals show as the heading's location.
# raw is the line as written, and text is the normalised name.
def collect-headings [text: string, label: string] {
    tag-fences $text
    | where fenced == false
    | where text =~ '^#{1,6}\s'
    | each {|l|
        let parts = $l.text | parse --regex '^(?<hashes>#{1,6})\s+(?<text>.*)$' | first

        {
            file: $label
            line: $l.line
            level: ($parts.hashes | str length)
            raw: ($l.text | str trim --right)
            text: (normalise-heading $parts.text)
        }
    }
}

# Returns how alike two normalised headings are, from 0.0 to 1.0.
#
# Returns 1.0 when every word of one heading appears in the other.
# So `Safety` and `Safety Rules` score 1.0 and count as the same name.
def heading-similarity [a: string, b: string] {
    if $a == $b {
        return 1.0
    }

    # The word check catches a heading that is another one plus extra words.
    # Edit distance misses that case, because the length gap lowers its score.
    # Edit distance catches a single reworded heading.
    let words_a = $a | split row " "
    let words_b = $b | split row " "

    let subset = (
        ($words_a | all {|w| $w in $words_b }) or ($words_b | all {|w| $w in $words_a })
    )

    if $subset {
        return 1.0
    }

    let longest = ([
        ($a | str length)
        ($b | str length)
    ] | math max)

    if $longest == 0 {
        return 0.0
    }

    1.0 - (($a | str distance $b) / $longest)
}

# Refuses on a level-six heading.
# Demoting it gives seven hashes, which turn the section into body text with no warning.
def check-max-level [headings: list<any>] {
    let deep = $headings | where level >= 6

    if ($deep | is-empty) {
        return
    }

    let listed = (
        $deep
        | each {|h| $"  (ansi red)($h.file):($h.line)(ansi reset)  ($h.raw)" }
        | str join "\n"
    )

    refuse "heading too deep to demote" $"($listed)\n\nEvery heading is demoted one level, and markdown stops at six. Use five hashes or fewer for these headings."
}

# Refuses when a heading in one source scores at least threshold against a heading in the other.
# Skips headings with no text.
def check-heading-clashes [machine: list<any>, personal: list<any>, threshold: float] {
    let named_personal = $personal | where text != ""

    let clashes = (
        $machine
        | where text != ""
        | each {|a|
            $named_personal
            | each {|b| {a: $a, b: $b, score: (heading-similarity $a.text $b.text)} }
        }
        | flatten
        | where score >= $threshold
        | sort-by score --reverse
    )

    if ($clashes | is-empty) {
        return
    }

    let width = (
        $clashes
        | each {|c| [
            ($"($c.a.file):($c.a.line)" | str length)
            ($"($c.b.file):($c.b.line)" | str length)
        ] }
        | flatten
        | math max
    )

    let detail = (
        $clashes
        | each {|c|
            let score = $c.score | math round --precision 2
            [
                $"  ($"($c.a.file):($c.a.line)" | fill --width $width)  ($c.a.raw)"
                $"  ($"($c.b.file):($c.b.line)" | fill --width $width)  ($c.b.raw)   \(score ($score)\)"
            ] | str join "\n"
        }
        | str join "\n\n"
    )

    refuse "similar headings across sources" $"($clashes | length) heading pair\(s\) look similar:\n\n($detail)\n\nRename one side of each pair, or raise (ansi blue)--similarity(ansi reset) \(currently ($threshold)\)."
}

# Merges the two rule sources into one generated agent file.
#
#   nu scripts/build-global-agents.nu                    rebuild the output
#   nu scripts/build-global-agents.nu --similarity 0.8   loosen the clash check
#
# Paths are relative to the repository root, not the working directory.
#
# Drops every heading one level.
# The output then has no level-one heading, so the two sources sit under the banner as peers.
#
# Refuses on a level-six heading, because it cannot drop a level.
# Refuses when a heading in one source scores at least --similarity against one in the other.
# A heading contained in a longer one scores 1.0, so `Safety` and `Safety Rules` always clash.
# Both checks run before the write, so a refusal leaves the previous output as it was.
#
# Exit codes: 0 done, 1 error, 2 refused.
def main [
    --machine: string = "global/machine-rules.md"   # first source, placed first in the output
    --personal: string = "global/personal-rules.md" # second source, placed after the first
    --out: string = "global/global-agents.md"       # generated file, overwritten on every run
    --similarity: float = 0.55                      # refuse when a heading pair scores at least this, 0.0 to 1.0
] {
    # Resolves paths from the script's location, so any working directory works.
    let root = $env.FILE_PWD | path join ".." | path expand

    let machine_path = $root | path join $machine
    let personal_path = $root | path join $personal
    let out_path = $root | path join $out

    let missing = (
        [$machine_path $personal_path]
        | where {|p| ($p | path exists) == false }
    )

    if ($missing | is-not-empty) {
        let listed = (
            $missing
            | each {|p| $"  (ansi red)(relative-or-absolute $p $root)(ansi reset)" }
            | str join "\n"
        )

        error make --unspanned {
            msg: "missing source file(s)"
            help: $"($listed)\n\nBoth sources must exist before merging. Check the (ansi blue)--machine(ansi reset) and (ansi blue)--personal(ansi reset) flags, or create the files."
        }
    }

    let machine_label = (relative-or-absolute $machine_path $root)
    let personal_label = (relative-or-absolute $personal_path $root)
    let out_label = (relative-or-absolute $out_path $root)

    let machine_text = open --raw $machine_path | str trim --right
    let personal_text = open --raw $personal_path | str trim --right

    let machine_headings = collect-headings $machine_text $machine_label
    let personal_headings = collect-headings $personal_text $personal_label

    # Keep both checks before the write, so a refusal leaves the previous output intact.
    check-max-level ($machine_headings | append $personal_headings)
    check-heading-clashes $machine_headings $personal_headings $similarity

    let banner = [
        "<!-- Generated by scripts/build-global-agents.nu. Do not edit. -->"
        $"<!-- Edit ($machine_label) and ($personal_label) instead. -->"
    ] | str join "\n"

    let merged = [
        (demote-headings $machine_text)
        (demote-headings $personal_text)
    ] | str join "\n\n"

    # Must stay above the save, because the save creates the file.
    let existed = $out_path | path exists

    $"($banner)\n\n($merged)\n" | save --force $out_path

    if $existed {
        print $"Updated (ansi yellow)($out_label)(ansi reset) \(previous contents overwritten\)"
    } else {
        print $"Created (ansi yellow)($out_label)(ansi reset)"
    }
}
