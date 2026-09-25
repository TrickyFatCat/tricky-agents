#!/usr/bin/env nu

def run-dprint [
    verb: string
    file: string
    fallback: string
] {
    let first = (^dprint $verb --no-gitignore $file | complete)

    # dprint publishes no exit code for a missing configuration, and 0.57.4
    # returns 11, which is not in its documented set. So the retry keys on the
    # message text instead.
    if ($first.exit_code != 0) and ($first.stderr | str contains "No config file found") {
        print -e $"No dprint configuration found. Retrying with the bundled fallback config: ($fallback)"
        let second = (^dprint $verb --no-gitignore --config $fallback $file | complete)
        {result: $second, config: "fallback"}
    } else {
        {result: $first, config: "project"}
    }
}

# Format one Markdown document with dprint.
#
# Reports what happened and decides nothing. The caller reads the exit code and
# the stdout record to choose its next step.
#
#   0   formatted, or already formatted
#   20  --check found unformatted content
#   3   dprint is not on PATH
#   2   the argument is not a single file, so nothing ran
#   1   dprint reported an error
def main [
    file: string    # One document. A directory or glob is refused.
    --check         # Report the formatting state without changing the file
] {
    # dprint expands a directory or glob into every file it matches, which would
    # reformat source material the caller was only reading.
    if ($file | path type) != "file" {
        print -e $"Refused: ($file) is not a single file. This script formats one document only."
        exit 2
    }

    # A script cannot report its own interpreter missing, so the caller checks
    # for nu before running this, and this checks for dprint.
    if (which dprint | is-empty) {
        print -e "dprint is not on PATH. Run the manual checks and report the document as not formatted."
        exit 3
    }

    # Resolved from the script's own location, because the working directory of
    # whoever called it is arbitrary.
    let fallback = ($env.FILE_PWD | path dirname | path join "assets" "dprint.default.jsonc")

    let verb = if $check { "check" } else { "fmt" }
    let outcome = (run-dprint $verb $file $fallback)
    let code = $outcome.result.exit_code

    let diagnostics = ($outcome.result.stderr | str trim)
    if $diagnostics != "" {
        print -e $diagnostics
    }

    let record = {
        formatted: ($code == 0)
        config: $outcome.config
        file: $file
    }
    print ($record | to json)

    if $code == 0 {
        exit 0
    }

    # 20 survives as itself so the caller can tell unformatted content from a
    # real failure. Every other code collapses to 1.
    if $code == 20 {
        exit 20
    }

    exit 1
}

# Sources
#
# Fetched 2026-09-20.
#
# - https://dprint.dev/cli/ - fmt, check, --config, exit codes 0, 1, 20
# - https://dprint.dev/config/
# - https://dprint.dev/plugins/markdown/
#
# Unverified
#
# dprint's configuration filename resolution order is not stated on the CLI or
# Config pages. The script therefore delegates discovery to dprint rather than
# reimplementing it.
