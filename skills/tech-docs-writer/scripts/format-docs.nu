#!/usr/bin/env nu

# Run dprint once, and retry with the bundled config when the project has none.
def run-dprint [
    verb: string
    file: string
    fallback: string
] {
    let first = (^dprint $verb $file | complete)

    if ($first.exit_code != 0) and ($first.stderr | str contains "No config file found") {
        print -e $"No dprint configuration found. Retrying with the bundled fallback config: ($fallback)"
        let second = (^dprint $verb --config $fallback $file | complete)
        {result: $second, config: "fallback"}
    } else {
        {result: $first, config: "project"}
    }
}

# Format one Markdown document with dprint.
#
# Reports what happened; decides nothing. Exits 0 when the file is formatted or
# already formatted, 20 when --check finds unformatted content, 3 when dprint is
# not on PATH, and 1 when dprint reports an error.
def main [
    file: string    # The one document to format
    --check         # Report whether the file is formatted, and change nothing
] {
    if (which dprint | is-empty) {
        print -e "dprint is not on PATH. Run the manual checks and report the document as not formatted."
        exit 3
    }

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
