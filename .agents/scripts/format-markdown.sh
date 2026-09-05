#!/usr/bin/env sh
set -eu

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 path/to/document.md [more-documents.md ...]" >&2
  exit 2
fi

if ! command -v dprint >/dev/null 2>&1; then
  echo "Error: dprint is not available on PATH." >&2
  exit 127
fi

for document in "$@"; do
  if [ ! -f "$document" ]; then
    echo "Error: not a file: $document" >&2
    exit 1
  fi

  if [ ! -r "$document" ]; then
    echo "Error: Markdown file is not readable: $document" >&2
    exit 1
  fi

  if [ ! -w "$document" ]; then
    echo "Error: Markdown file is not writable: $document" >&2
    exit 1
  fi

  case "$document" in
    *.md|*.markdown) ;;
    *)
      echo "Error: expected a Markdown file: $document" >&2
      exit 1
      ;;
  esac

done

dprint fmt --no-gitignore "$@"
