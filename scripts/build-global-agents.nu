#!/usr/bin/env nu

# Merge the hand-edited rule sources into one generated agent file.
#
#   nu scripts/build-global-agents.nu                    rebuild the output
#   nu scripts/build-global-agents.nu --similarity 0.8   loosen the clash check
#
#   global/machine-rules.md    hand-edited
#   global/personal-rules.md   hand-edited
#   global/global-agents.md    generated, overwritten every run
#
# Every heading drops one level, so the output carries no level-one heading and
# the two sources sit under the banner as peers.
#
# The build refuses before writing, so a failed run leaves the previous output
# intact. It stops on a heading too deep to demote, and on a heading in one
# source that reads like one in the other.

# Print a refusal and exit 2.
#
# A refusal is not an error. The sources are readable and the flags are valid;
# the build is declining because it cannot produce a correct file. Plain output
# rather than Nushell's error box, so the two read differently.
def refuse [msg: string, detail: string] {
    print -e $"(ansi red)Refused(ansi reset): ($msg)\n"
    print -e $detail
    exit 2
}

# Relative to the root when the path sits under it, absolute otherwise.
def relative-or-absolute [path: string, root: string] {
    try {
        $path | path relative-to $root
    } catch { $path }
}

# Every line as {line, text, fenced}. The ``` markers count as fenced too, so a
# fence line is never read as content.
#
# Shared by the demoter and the collector. Two copies of this state machine
# would drift apart.
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

# Drop every heading one level. Hashes must be followed by whitespace, so a line
# like `#hashtag` is left alone.
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

# The form the clash check compares, never written to the output. Two headings
# that differ only in case, emphasis or trailing punctuation are the same name.
def normalise-heading [text: string] {
    $text
    | str replace --all --regex '\s+#+\s*$' ''
    | str replace --all --regex '[`*_]' ''
    | str replace --all --regex '[.,:;!?]+$' ''
    | str lowercase
    | str replace --all --regex '\s+' ' '
    | str trim
}

# Every heading as {file, line, level, raw, text}. Line numbers are one-based.
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

# How alike two normalised headings are, 0.0 to 1.0.
#
# Whichever of two signals scores higher. Word subset catches a heading that is
# another one plus extra words, where edit distance is dragged down by the
# length gap. Edit distance catches a single reworded heading.
#
# Subset scores a flat 1.0, so a short heading contained in a longer one always
# clashes: `Safety` and `Safety Rules` count as the same name.
def heading-similarity [a: string, b: string] {
    if $a == $b {
        return 1.0
    }

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

# Abort on a level-6 heading. Demoting it would emit seven hashes, which markdown
# does not recognise, and the section would silently become body text.
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

    refuse "heading too deep to demote" $"($listed)\n\nEvery heading is demoted one level, and markdown stops at six. Raise these headings, or split the section into its own file."
}

# Abort when any heading in one source resembles a heading in the other.
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

    # Pad both locations to the same width so each pair lines up as a pair.
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

def main [
    --machine: string = "global/machine-rules.md"   # source read first
    --personal: string = "global/personal-rules.md" # source read second
    --out: string = "global/global-agents.md"       # generated file
    --similarity: float = 0.55                      # stop when a heading pair scores at least this, 0.0 to 1.0
] {
    # From the script's own location, so any working directory works.
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

    # Both run before any write, so a refusal leaves the previous output intact.
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

    # Captured before the write, because `save --force` reports nothing.
    let existed = $out_path | path exists

    $"($banner)\n\n($merged)\n" | save --force $out_path

    if $existed {
        print $"Updated (ansi yellow)($out_label)(ansi reset) \(previous contents overwritten\)"
    } else {
        print $"Created (ansi yellow)($out_label)(ansi reset)"
    }
}
