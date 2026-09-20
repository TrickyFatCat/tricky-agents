#!/usr/bin/env python3
"""Mechanical checks for an agent Skill folder.

Reports. Never decides, never writes, never reaches the network.
"""

# Bytecode writing is disabled before anything else is imported, so no
# __pycache__ directory is ever created by this run.
import sys

sys.dont_write_bytecode = True

MIN_PYTHON = (3, 11)

if sys.version_info < MIN_PYTHON:
    sys.stderr.write(
        "check.py needs Python %d.%d or newer. This interpreter is %d.%d.\n"
        % (MIN_PYTHON[0], MIN_PYTHON[1], sys.version_info[0], sys.version_info[1])
    )
    sys.stderr.write("Run it with a Python 3.11+ interpreter.\n")
    raise SystemExit(2)

import argparse
import json
import re
import subprocess
from pathlib import Path

try:
    import yaml
except ImportError:
    yaml = None


# --- Specification constants -------------------------------------------------
#
# Source: https://agentskills.io/specification
#         https://agentskills.io/skill-creation/best-practices
# These limits are duplicated in references/skill-spec.md for the agent to
# read. Both copies carry this date, and a mismatch is a finding.

SPEC_URL = "https://agentskills.io/specification"
SPEC_DATE = "2026-09-20"

MAX_SKILL_LINES = 500
MAX_SKILL_TOKENS = 5000
MAX_NAME_CHARS = 64
MAX_DESCRIPTION_CHARS = 1024
MAX_COMPATIBILITY_CHARS = 500

NEAR_LIMIT_FRACTION = 0.10
CHARS_PER_TOKEN = 4

MAX_FINDINGS = 50
MAX_SCAN_BYTES = 1024 * 1024

NAME_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
TRIGGER_WORDS = ("must", "never", "only", "ask")
TRIGGER_PATTERN = re.compile(
    r"\b(?:%s)\b" % "|".join(TRIGGER_WORDS), re.IGNORECASE
)

KNOWN_FOLDERS = ("references/", "scripts/", "assets/", "tests/")
PATTERN_GROUPS = ("S1", "S2", "S3", "S4", "S5")

TEXT_SUFFIXES = {
    ".md", ".py", ".sh", ".nu", ".js", ".ts", ".rb", ".ps1",
    ".txt", ".toml", ".yaml", ".yml", ".json", ".cfg", ".ini", "",
}

FLAG_NAMES = {
    "ignorecase": re.IGNORECASE,
    "dotall": re.DOTALL,
    "multiline": re.MULTILINE,
}

SUBCOMMANDS = ("spec", "routes", "size", "permission-lines", "safety", "all")


class UsageError(Exception):
    """Raised for a bad invocation. Reported on stderr, exit 2."""


# --- Small helpers -----------------------------------------------------------


def normalise(text):
    """Normalise line endings before anything is matched against them."""
    return text.replace("\r\n", "\n").replace("\r", "\n")


def read_text(path):
    """Read a file as UTF-8. Returns None when it is not decodable text."""
    try:
        data = path.read_bytes()
    except OSError:
        return None
    if b"\x00" in data:
        return None
    return normalise(data.decode("utf-8", "replace"))


def rel(path, root):
    """Path relative to the skill root, always with forward slashes."""
    try:
        return path.resolve().relative_to(root).as_posix()
    except ValueError:
        return path.as_posix()


def is_inside(path, root):
    try:
        path.resolve().relative_to(root)
        return True
    except ValueError:
        return False


def result(check, status, findings=None, reason=None, extra=None):
    findings = findings or []
    total = len(findings)
    shown = findings[:MAX_FINDINGS]
    out = {
        "check": check,
        "status": status,
        "reason": reason,
        "total": total,
        "truncated": total > MAX_FINDINGS,
        "findings": shown,
    }
    if extra:
        out.update(extra)
    return out


def finding(fid, file, line, message, **extra):
    item = {"id": fid, "file": file, "line": line, "message": message}
    item.update(extra)
    return item


def strip_fenced_blocks(text):
    """Blank out fenced code blocks, keeping line numbering intact.

    A path inside a fenced example is illustration, not a reference.
    """
    out = []
    fenced = False
    for line in text.split("\n"):
        if line.lstrip().startswith("```"):
            fenced = not fenced
            out.append("")
            continue
        out.append("" if fenced else line)
    return "\n".join(out)


def markdown_files(root):
    return sorted(p for p in root.rglob("*.md") if p.is_file())


def scannable_files(root):
    found = []
    for p in sorted(root.rglob("*")):
        if not p.is_file():
            continue
        if p.suffix.lower() in TEXT_SUFFIXES:
            found.append(p)
    return found


# --- Frontmatter -------------------------------------------------------------


def split_frontmatter(text):
    """Return (yaml_text, body_start_line) or (None, 0)."""
    lines = text.split("\n")
    if not lines or lines[0].strip() != "---":
        return None, 0
    for index in range(1, len(lines)):
        if lines[index].strip() == "---":
            return "\n".join(lines[1:index]), index + 1
    return None, 0


# --- spec --------------------------------------------------------------------


def check_spec(skill):
    name = "spec"
    skill_md = skill / "SKILL.md"
    text = read_text(skill_md)
    if text is None:
        return result(name, "error", reason="SKILL.md could not be read")

    raw, _ = split_frontmatter(text)
    if raw is None:
        return result(
            name,
            "findings",
            [
                finding(
                    "spec-frontmatter-missing",
                    "SKILL.md",
                    1,
                    "No YAML frontmatter. SKILL.md must open with a --- block.",
                )
            ],
        )

    if yaml is None:
        return result(
            name,
            "limited",
            reason="PyYAML is not installed, so frontmatter was not parsed",
        )

    try:
        data = yaml.safe_load(raw)
    except yaml.YAMLError as exc:
        return result(
            name,
            "findings",
            [
                finding(
                    "spec-frontmatter-invalid",
                    "SKILL.md",
                    1,
                    "Frontmatter is not valid YAML: %s" % str(exc).split("\n")[0],
                )
            ],
        )

    if not isinstance(data, dict):
        return result(
            name,
            "findings",
            [
                finding(
                    "spec-frontmatter-invalid",
                    "SKILL.md",
                    1,
                    "Frontmatter is not a mapping of fields.",
                )
            ],
        )

    found = []
    found.extend(_check_name(data, skill))
    found.extend(_check_description(data))
    found.extend(_check_optional(data))
    return result(name, "findings" if found else "pass", found)


def _check_name(data, skill):
    out = []
    value = data.get("name")
    if value is None:
        out.append(
            finding("spec-name-missing", "SKILL.md", 1, "`name` is required.")
        )
        return out
    if not isinstance(value, str):
        out.append(
            finding(
                "spec-name-type",
                "SKILL.md",
                1,
                "`name` must be text, not %s." % type(value).__name__,
            )
        )
        return out
    if not 1 <= len(value) <= MAX_NAME_CHARS:
        out.append(
            finding(
                "spec-name-length",
                "SKILL.md",
                1,
                "`name` must be 1 to %d characters, and is %d."
                % (MAX_NAME_CHARS, len(value)),
            )
        )
    if not NAME_PATTERN.match(value):
        out.append(
            finding(
                "spec-name-charset",
                "SKILL.md",
                1,
                "`name` allows lower-case letters, digits and single hyphens "
                "only, and must not start or end with a hyphen.",
            )
        )
    if value != skill.name:
        out.append(
            finding(
                "spec-name-folder",
                "SKILL.md",
                1,
                "`name` is %r but the folder is %r. They must match."
                % (value, skill.name),
            )
        )
    return out


def _check_description(data):
    out = []
    value = data.get("description")
    if value is None:
        out.append(
            finding(
                "spec-description-missing",
                "SKILL.md",
                1,
                "`description` is required.",
            )
        )
        return out
    if not isinstance(value, str):
        out.append(
            finding(
                "spec-description-type",
                "SKILL.md",
                1,
                "`description` must be text, not %s." % type(value).__name__,
            )
        )
        return out
    if not value.strip():
        out.append(
            finding(
                "spec-description-empty",
                "SKILL.md",
                1,
                "`description` must not be empty.",
            )
        )
    if len(value) > MAX_DESCRIPTION_CHARS:
        out.append(
            finding(
                "spec-description-length",
                "SKILL.md",
                1,
                "`description` is %d characters, over the %d limit."
                % (len(value), MAX_DESCRIPTION_CHARS),
                characters=len(value),
            )
        )
    return out


def _check_optional(data):
    out = []
    compatibility = data.get("compatibility")
    if compatibility is not None:
        if not isinstance(compatibility, str):
            out.append(
                finding(
                    "spec-compatibility-type",
                    "SKILL.md",
                    1,
                    "`compatibility` must be text.",
                )
            )
        elif len(compatibility) > MAX_COMPATIBILITY_CHARS:
            out.append(
                finding(
                    "spec-compatibility-length",
                    "SKILL.md",
                    1,
                    "`compatibility` is %d characters, over the %d limit."
                    % (len(compatibility), MAX_COMPATIBILITY_CHARS),
                )
            )

    metadata = data.get("metadata")
    if metadata is not None:
        if not isinstance(metadata, dict):
            out.append(
                finding(
                    "spec-metadata-type",
                    "SKILL.md",
                    1,
                    "`metadata` must be a mapping.",
                )
            )
        else:
            for key, value in metadata.items():
                if not isinstance(key, str) or not isinstance(value, str):
                    out.append(
                        finding(
                            "spec-metadata-values",
                            "SKILL.md",
                            1,
                            "`metadata` maps string keys to string values; "
                            "%r is not." % (key,),
                        )
                    )
                    break

    tools = data.get("allowed-tools")
    if tools is not None and not isinstance(tools, str):
        out.append(
            finding(
                "spec-allowed-tools-type",
                "SKILL.md",
                1,
                "`allowed-tools` must be a space-separated string.",
            )
        )
    return out


# --- size --------------------------------------------------------------------


def check_size(skill):
    name = "size"
    skill_md = skill / "SKILL.md"
    text = read_text(skill_md)
    if text is None:
        return result(name, "error", reason="SKILL.md could not be read")

    lines = len(text.split("\n"))
    characters = len(text)
    tokens = characters // CHARS_PER_TOKEN

    found = []
    found.extend(_size_finding("lines", lines, MAX_SKILL_LINES, "size-lines"))
    found.extend(
        _size_finding("tokens", tokens, MAX_SKILL_TOKENS, "size-tokens")
    )

    measured = {
        "lines": lines,
        "characters": characters,
        "tokens_estimate": tokens,
        "tokens_note": "estimate: characters divided by %d" % CHARS_PER_TOKEN,
    }
    return result(
        name,
        "findings" if found else "pass",
        found,
        extra={"measured": measured},
    )


def _size_finding(label, value, limit, fid):
    if value > limit:
        return [
            finding(
                fid + "-over",
                "SKILL.md",
                1,
                "SKILL.md is %d %s, over the %d limit." % (value, label, limit),
                value=value,
                limit=limit,
            )
        ]
    if value >= limit * (1 - NEAR_LIMIT_FRACTION):
        return [
            finding(
                fid + "-near",
                "SKILL.md",
                1,
                "SKILL.md is %d %s, near the %d limit." % (value, label, limit),
                value=value,
                limit=limit,
            )
        ]
    return []


# --- routes ------------------------------------------------------------------

LINK_PATTERN = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
CODE_SPAN_PATTERN = re.compile(r"`([^`\n]+)`")


def check_routes(skill):
    name = "routes"
    skill_md = skill / "SKILL.md"
    text = read_text(skill_md)
    if text is None:
        return result(name, "error", reason="SKILL.md could not be read")

    found = []
    named = _named_references(text)

    references_dir = skill / "references"
    if references_dir.is_dir():
        for path in sorted(references_dir.glob("*.md")):
            key = "references/" + path.name
            if key not in named:
                found.append(
                    finding(
                        "routes-unnamed",
                        key,
                        1,
                        "This reference is never named in SKILL.md, so nothing "
                        "routes to it.",
                    )
                )

    for key in sorted(named):
        if not (skill / key).is_file():
            found.append(
                finding(
                    "routes-missing",
                    "SKILL.md",
                    named[key],
                    "SKILL.md names %s, which does not exist." % key,
                )
            )

    found.extend(_check_links(skill))
    return result(name, "findings" if found else "pass", found)


def _named_references(text):
    """Reference paths named in SKILL.md, mapped to their first line."""
    stripped = strip_fenced_blocks(text)
    named = {}
    for number, line in enumerate(stripped.split("\n"), start=1):
        for span in CODE_SPAN_PATTERN.findall(line):
            candidate = span.strip()
            if candidate.startswith("references/") and candidate.endswith(".md"):
                named.setdefault(candidate, number)
        for target in LINK_PATTERN.findall(line):
            candidate = target.split("#")[0].strip()
            if candidate.startswith("references/") and candidate.endswith(".md"):
                named.setdefault(candidate, number)
    return named


def _check_links(skill):
    found = []
    for path in markdown_files(skill):
        text = read_text(path)
        if text is None:
            continue
        where = rel(path, skill)
        stripped = strip_fenced_blocks(text)
        for number, line in enumerate(stripped.split("\n"), start=1):
            for target in LINK_PATTERN.findall(line):
                found.extend(
                    _resolve_target(
                        target, path, skill, where, number, "routes-link"
                    )
                )
            for span in CODE_SPAN_PATTERN.findall(line):
                candidate = span.strip()
                if not candidate.startswith(KNOWN_FOLDERS):
                    continue
                found.extend(
                    _resolve_target(
                        candidate, skill / "x", skill, where, number,
                        "routes-path",
                    )
                )
    return found


def _resolve_target(target, source, skill, where, number, fid):
    target = target.strip()
    if not target or target.startswith("#"):
        return []
    lowered = target.lower()
    for scheme in ("http://", "https://", "mailto:", "ftp://"):
        if lowered.startswith(scheme):
            return []
    if "://" in target:
        return []

    clean = target.split("#")[0].split("?")[0].strip()
    if not clean:
        return []

    resolved = (source.parent / clean).resolve()
    if not is_inside(resolved, skill):
        return [
            finding(
                fid + "-outside",
                where,
                number,
                "%s resolves outside the skill folder." % target,
            )
        ]
    if not resolved.exists():
        return [
            finding(
                fid + "-missing",
                where,
                number,
                "%s does not exist." % target,
            )
        ]
    return []


# --- safety ------------------------------------------------------------------

BLOCK_START = "```safety-patterns"


def parse_patterns(text):
    """Parse safety-patterns blocks.

    Returns (patterns, problems). A malformed record is reported and skipped.
    """
    patterns = []
    problems = []
    lines = text.split("\n")
    index = 0
    while index < len(lines):
        if lines[index].strip() != BLOCK_START:
            index += 1
            continue
        index += 1
        record = []
        start = index + 1
        while index < len(lines) and not lines[index].strip().startswith("```"):
            if lines[index].strip() == "":
                if record:
                    _add_record(record, start, patterns, problems)
                record = []
                start = index + 2
            else:
                if not record:
                    start = index + 1
                record.append(lines[index])
            index += 1
        if record:
            _add_record(record, start, patterns, problems)
        index += 1
    return patterns, problems


def _add_record(record, line_number, patterns, problems):
    fields = {}
    for raw in record:
        key, sep, value = raw.partition(": ")
        if not sep:
            problems.append(
                (fields.get("id", "?"), line_number, "Line has no `key: value`.")
            )
            return
        fields[key.strip()] = value
    pattern_id = fields.get("id", "?")

    for required in ("id", "match", "finds"):
        if not fields.get(required):
            problems.append(
                (pattern_id, line_number, "Record has no `%s`." % required)
            )
            return

    group = pattern_id.split("-")[0]
    if group not in PATTERN_GROUPS:
        problems.append(
            (pattern_id, line_number, "id must start with S1 to S5.")
        )
        return

    flags = 0
    if fields.get("flags"):
        for token in fields["flags"].split(","):
            token = token.strip().lower()
            if token not in FLAG_NAMES:
                problems.append(
                    (pattern_id, line_number, "Unknown flag %r." % token)
                )
                return
            flags |= FLAG_NAMES[token]

    try:
        compiled = re.compile(fields["match"], flags)
    except re.error as exc:
        problems.append(
            (pattern_id, line_number, "Invalid regular expression: %s" % exc)
        )
        return

    patterns.append(
        {
            "id": pattern_id,
            "group": group,
            "regex": compiled,
            "finds": fields["finds"],
        }
    )


def check_safety(skill, patterns_path):
    name = "safety"
    text = read_text(patterns_path)
    if text is None:
        return result(
            name,
            "error",
            reason="Pattern file could not be read: %s" % patterns_path.as_posix(),
        )

    patterns, problems = parse_patterns(text)
    counts = {}
    for group in PATTERN_GROUPS:
        counts[group] = 0
    for item in patterns:
        counts[item["group"]] += 1

    extra = {
        "pattern_file": patterns_path.as_posix(),
        "pattern_counts": counts,
    }

    empty = [group for group in PATTERN_GROUPS if counts[group] == 0]
    if empty:
        return result(
            name,
            "error",
            reason="No patterns in group(s): %s" % ", ".join(empty),
            extra=extra,
        )

    found = []
    for pattern_id, line_number, message in problems:
        found.append(
            finding(
                "safety-record",
                rel(patterns_path, skill),
                line_number,
                "Pattern %s skipped. %s" % (pattern_id, message),
            )
        )

    excluded = patterns_path.resolve()
    skipped = []
    for path in scannable_files(skill):
        if path.resolve() == excluded:
            continue
        try:
            if path.stat().st_size > MAX_SCAN_BYTES:
                skipped.append(rel(path, skill))
                continue
        except OSError:
            skipped.append(rel(path, skill))
            continue
        content = read_text(path)
        if content is None:
            continue
        where = rel(path, skill)
        for number, line in enumerate(content.split("\n"), start=1):
            for item in patterns:
                if item["regex"].search(line):
                    found.append(
                        finding(
                            item["id"], where, number, item["finds"]
                        )
                    )

    status = "findings" if found else "pass"
    reason = None
    if problems:
        status = "limited"
        reason = "%d pattern record(s) skipped" % len(problems)
    if skipped:
        status = "limited"
        extra["skipped_files"] = skipped
        note = "%d file(s) over 1 MB skipped" % len(skipped)
        reason = note if reason is None else reason + "; " + note

    return result(name, status, found, reason=reason, extra=extra)


# --- permission-lines --------------------------------------------------------


def trigger_lines(text):
    out = {}
    for number, line in enumerate(text.split("\n"), start=1):
        if TRIGGER_PATTERN.search(line):
            out[line.strip()] = number
    return out


def git_toplevel(skill):
    try:
        done = subprocess.run(
            [
                "git",
                "--no-optional-locks",
                "-C",
                str(skill),
                "rev-parse",
                "--show-toplevel",
            ],
            capture_output=True,
            text=True,
            timeout=20,
        )
    except (OSError, subprocess.SubprocessError):
        return None
    if done.returncode != 0:
        return None
    return Path(done.stdout.strip())


def git_show(top, relative):
    try:
        done = subprocess.run(
            [
                "git",
                "--no-optional-locks",
                "-C",
                str(top),
                "show",
                "HEAD:" + relative,
            ],
            capture_output=True,
            text=True,
            timeout=20,
        )
    except (OSError, subprocess.SubprocessError):
        return None
    if done.returncode != 0:
        return None
    return normalise(done.stdout)


def check_permission_lines(skill, base, files):
    name = "permission-lines"
    targets = files if files else _default_targets(skill)

    top = None if base else git_toplevel(skill)
    if base is None and top is None:
        found = []
        for path in targets:
            text = read_text(path)
            if text is None:
                continue
            where = rel(path, skill)
            for line, number in trigger_lines(text).items():
                found.append(
                    finding(
                        "perm-unbaselined",
                        where,
                        number,
                        "Trigger-word line, no baseline to compare with: %s"
                        % _clip(line),
                    )
                )
        return result(name, "limited", found, reason="no baseline")

    found = []
    unavailable = []
    for path in targets:
        text = read_text(path)
        if text is None:
            continue
        where = rel(path, skill)
        previous = _baseline_text(path, skill, base, top)
        if previous is None:
            unavailable.append(where)
            continue
        before = trigger_lines(previous)
        now = trigger_lines(text)
        for line, number in now.items():
            if line not in before:
                found.append(
                    finding(
                        "perm-added",
                        where,
                        number,
                        "Trigger-word line added or changed: %s" % _clip(line),
                    )
                )
        # A deleted obligation is the dangerous direction: the new wording may
        # contain no trigger word at all, so only the baseline still shows it.
        for line, number in before.items():
            if line not in now:
                found.append(
                    finding(
                        "perm-removed",
                        where,
                        number,
                        "Trigger-word line removed or reworded: %s" % _clip(line),
                        baseline_line=number,
                    )
                )

    status = "findings" if found else "pass"
    reason = None
    if unavailable:
        status = "limited"
        reason = "no baseline for %d file(s)" % len(unavailable)
    return result(name, status, found, reason=reason)


def _default_targets(skill):
    targets = []
    for path in scannable_files(skill):
        if path.suffix.lower() in (".md", ".py", ".sh", ".nu"):
            targets.append(path)
    return targets


def _baseline_text(path, skill, base, top):
    if base is not None:
        candidate = base / rel(path, skill)
        if candidate.is_file():
            return read_text(candidate)
        return None
    try:
        relative = path.resolve().relative_to(top.resolve()).as_posix()
    except ValueError:
        return None
    return git_show(top, relative)


def _clip(line, width=90):
    line = line.strip()
    return line if len(line) <= width else line[: width - 1] + "…"


# --- Driver ------------------------------------------------------------------

HELP_EPILOG = """\
subcommands:
  spec              frontmatter fields and types
  routes            references exist and are named; links resolve inside the skill
  size              SKILL.md lines, characters, and a token estimate
  permission-lines  changed lines containing must, never, only or ask
  safety            pattern matches from references/safety.md
  all               every check above, in one report

exit codes:
  0  every check passed
  1  at least one check has findings
  2  usage error, Python too old, or a check could not run
  3  no findings, at least one check limited

The token count is an estimate: characters divided by 4. No tokenizer is used.
Output is JSON on stdout; diagnostics go to stderr. Nothing is ever written.
"""


def build_parser():
    parser = argparse.ArgumentParser(
        prog="check.py",
        description="Mechanical checks for an agent Skill folder.",
        epilog=HELP_EPILOG,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("subcommand", choices=SUBCOMMANDS)
    parser.add_argument("skill_dir", help="Path to the skill folder")
    parser.add_argument(
        "--base",
        metavar="PATH",
        help="Baseline copy for permission-lines, outside the skill folder",
    )
    parser.add_argument(
        "--files",
        metavar="PATH",
        nargs="+",
        help="Limit permission-lines to these files",
    )
    parser.add_argument(
        "--patterns",
        metavar="PATH",
        help="Safety pattern file. Defaults to this script's own references/safety.md",
    )
    return parser


def default_patterns_path():
    return Path(__file__).resolve().parent.parent / "references" / "safety.md"


def resolve_arguments(args):
    skill = Path(args.skill_dir).resolve()
    if not skill.is_dir():
        raise UsageError("Not a directory: %s" % args.skill_dir)
    if not (skill / "SKILL.md").is_file():
        raise UsageError("No SKILL.md in %s" % args.skill_dir)

    default_patterns = default_patterns_path()
    if args.patterns:
        patterns = Path(args.patterns).resolve()
        if not patterns.is_file():
            raise UsageError("Pattern file not found: %s" % args.patterns)
        if is_inside(patterns, skill) and patterns != default_patterns:
            raise UsageError(
                "Refusing a pattern file inside the skill being checked: %s\n"
                "A skill could otherwise supply the patterns used to check it."
                % args.patterns
            )
    else:
        patterns = default_patterns

    base = None
    if args.base:
        base = Path(args.base).resolve()
        if not base.is_dir():
            raise UsageError("Baseline is not a directory: %s" % args.base)
        if is_inside(base, skill):
            raise UsageError(
                "The baseline copy must sit outside the skill folder: %s"
                % args.base
            )

    files = []
    for item in args.files or []:
        path = Path(item)
        if not path.is_absolute():
            path = skill / item
        path = path.resolve()
        if not path.is_file():
            raise UsageError("Not a file: %s" % item)
        if not is_inside(path, skill):
            raise UsageError("File is outside the skill folder: %s" % item)
        files.append(path)

    return skill, patterns, base, files


def run(subcommand, skill, patterns, base, files):
    wanted = SUBCOMMANDS[:-1] if subcommand == "all" else (subcommand,)
    results = []
    for item in wanted:
        if item == "spec":
            results.append(check_spec(skill))
        elif item == "routes":
            results.append(check_routes(skill))
        elif item == "size":
            results.append(check_size(skill))
        elif item == "permission-lines":
            results.append(check_permission_lines(skill, base, files))
        elif item == "safety":
            results.append(check_safety(skill, patterns))
    return results


def exit_code(results):
    if any(item["status"] == "error" for item in results):
        return 2
    if any(item["findings"] for item in results):
        return 1
    if any(item["status"] == "findings" for item in results):
        return 1
    if any(item["status"] == "limited" for item in results):
        return 3
    return 0


def main(argv):
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        skill, patterns, base, files = resolve_arguments(args)
    except UsageError as exc:
        sys.stderr.write("check.py: %s\n" % exc)
        return 2

    results = run(args.subcommand, skill, patterns, base, files)
    report = {
        "tool": "check.py",
        "spec_date": SPEC_DATE,
        "spec_url": SPEC_URL,
        "skill": skill.as_posix(),
        "results": results,
    }
    sys.stdout.write(json.dumps(report, indent=2, ensure_ascii=False) + "\n")
    return exit_code(results)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
