#!/usr/bin/env nu

def run-dprint [
    verb: string
    file: string
    fallback: string
] {
    # Formats the named file even when git ignores it, because the caller chose that file.
    let first = (^dprint $verb --no-gitignore $file | complete)

    # Matches the message text, because dprint documents no exit code for a missing config.
    if ($first.exit_code != 0) and ($first.stderr | str contains "No config file found") {
        print -e $"No dprint configuration found. Retrying with the bundled fallback config: ($fallback)"
        let second = (^dprint $verb --no-gitignore --config $fallback $file | complete)
        {result: $second, config: "fallback"}
    } else {
        {result: $first, config: "project"}
    }
}

# Formats one Markdown document with dprint.
#
# Prints a JSON record to stdout with the fields formatted, config and file.
#
#   0   formatted, or already formatted
#   20  --check found unformatted content
#   3   dprint is not on PATH
#   2   the argument is not a single file, so nothing ran
#   1   dprint reported an error
def main [
    file: string    # One document, never a directory or a glob
    --check         # Reports the formatting state without changing the file
] {
    # Refuses anything but one file, so dprint cannot format files the caller only reads.
    if ($file | path type) != "file" {
        print -e $"Refused: ($file) is not a single file. This script formats one document only."
        exit 2
    }

    # Checks only for dprint, because the caller checks for nu before running this script.
    if (which dprint | is-empty) {
        print -e "dprint is not on PATH. Run the manual checks and report the document as not formatted."
        exit 3
    }

    # Finds the fallback from the script's own location, because the caller may run it from any folder.
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

    # Keeps 20 so the caller can tell unformatted content from a real failure.
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
# Checked 2026-09-25 in dprint 0.57.4.
#
# - `dprint fmt --help` - --no-gitignore
# - `dprint --help` - config file names, and the search from the current directory upward
# - `dprint --help` - the global config in DPRINT_CONFIG_DIR
#
# Unverified
#
# The help does not state when dprint uses the global config instead of a local one.
# So the script lets dprint find the config instead of searching itself.
