#!/usr/bin/env bash
# PreToolUse hook for Bash: hard-deny any command whose text references a
# protected path.
#
# Why this exists: permissions.deny covers Read/Edit/Glob/Grep but NOT Bash.
# Every PDF and docx read during the 2026-08-02 GRTI session came through
# `uv run python` inside Bash, which no Read deny rule would have stopped.
# Without this hook the deny rules are a fence with the gate standing open.
#
# Protected categories:
#   EmployeeInfo, TenureFile        Dax's own personnel material (Dropbox)
#   SEES P&B committee,             OTHER PEOPLE's personnel material: promotion
#   Promotion Folder,               and reappointment files belonging to
#   reappointments                  colleagues. Added 2026-09-07. Arguably the
#                                   more serious category, because it is not
#                                   Dax's to expose.
#   accommodations, finalGrades     protected student records (FERPA). Named as
#                                   never-paste in the GEOL 333 instructions;
#                                   added here 2026-09-07 so the guard covers
#                                   them too.
#   _NONPUBLIC_copilot_only         non-public institutional material; per CUNY
#                                   policy this belongs in CUNY Copilot, the only
#                                   licensed GenAI service approved for
#                                   non-public, internal, and sensitive data
#   _EMBARGOED_do_not_access        course embargo (matches the existing denies)
#
# Two kinds of check run here, because there are two ways to reach the material:
#   1. A command that NAMES a protected path (the original case statement).
#   2. A recursive search ROOTED ABOVE a protected tree, which names nothing
#      protected and leaks it in the output (the broad-search guard).
#
# Exits 0 silently when nothing matches.

set -euo pipefail

payload=$(cat)

command_text=$(printf '%s' "$payload" | python3 -c 'import json, sys
try:
    p = json.load(sys.stdin)
    print(p.get("tool_input", {}).get("command", ""))
except Exception:
    pass')

[ -z "${command_text:-}" ] && exit 0

# Match PATH references, not bare words: a real access has a slash next to the
# name. Matching the bare word made the hook block its own commit message, which
# merely described the protected directories (2026-08-02). A Python one-liner
# that assembles the path from fragments would still evade this; the hook is a
# guardrail against accident, not an adversary.
#
# Deliberately over-broad in one direction: a prefix match means an unrelated
# file named e.g. EmployeeInfoNotes.md is also denied. Requiring a slash on BOTH
# sides would fix that but would miss `ls <path>/EmployeeInfo` on the directory
# itself, which is the case most worth catching. Fail toward denial.
#
# Testing note: you cannot exercise this hook from a Bash command line, because
# any command containing a protected path is blocked before it runs (including
# the test itself). The payloads therefore live in a file that is fed to this
# hook as a subprocess:
#
#     python3 ~/repos/claude-config/tools/test_copilot_firewall.py
#
# 24 cases as of 2026-09-07, covering both guards and the narrow searches that
# must keep working. Write that file with the Write tool, not a Bash heredoc:
# a heredoc containing a protected name is itself blocked.
category=""
guidance=""

# --- Guard 2: a recursive search rooted above a protected tree --------------
#
# Added 2026-09-07 after a real leak. This ran cleanly:
#
#     find ~/Queens\ College\ Dropbox -iname "*offer*letter*"
#
# It names no protected path, so the case statement below never saw it, and its
# OUTPUT listed both a TenureFile path and another faculty member's promotion
# folder. Filenames alone disclose: a directory named for a colleague plus
# "Promotion Folder" reveals a personnel action. The case statement screens the
# command; it cannot screen results. A search rooted above a protected tree
# walks that tree regardless of what the command says.
#
# The rule: you may not recursively search a directory that CONTAINS protected
# material. Search a narrower directory instead. The depth bound below is not
# arbitrary — on this machine the personnel trees sit four levels under $HOME
# (<Dropbox>/<account>/AllFiles/QueensCollege/EmployeeInfo and
# <Dropbox>/<account>/SEES P&B committee), so any Dropbox root at depth <= 4,
# and $HOME itself, is an ancestor of protected material.
#
# An explicit -prune / --exclude-dir is accepted as deliberate narrowing.
search_root=$(printf '%s' "$command_text" | python3 -c '
import os
import re
import sys

cmd = sys.stdin.read()


def strip_heredocs(text):
    """Drop heredoc bodies: they are data, not commands.

    Without this, a commit message quoting a broad search trips this guard,
    which is how this hook first blocked its own commit on 2026-09-07. Guard 1
    below still sees heredoc bodies; only this search check is narrowed, since
    a search inside a heredoc body is not a search being run.
    """
    lines = text.split("\n")
    kept = []
    i = 0
    while i < len(lines):
        kept.append(lines[i])
        opener = re.search(r"<<-?\s*[\"'\'']?([A-Za-z_][A-Za-z0-9_]*)[\"'\'']?", lines[i])
        i += 1
        if not opener:
            continue
        tag = opener.group(1)
        while i < len(lines) and lines[i].strip() != tag:
            i += 1
        if i < len(lines):
            kept.append(lines[i])
            i += 1
    return "\n".join(kept)


cmd = strip_heredocs(cmd)

# Recursive-search tools. grep only counts with a recursive flag.
RECURSIVE = re.compile(r"(?:\A|[;&|(`]|\s)\s*(?:sudo\s+)?(?:find|fd|rg|ag|ack|tree)\b")
GREP_R = re.compile(r"\bgrep\b[^|;]*\s-[A-Za-z]*[rR]")
if not RECURSIVE.search(cmd) and not GREP_R.search(cmd):
    sys.exit(0)

# Deliberate narrowing: the caller has excluded the protected names by hand.
if re.search(r"-prune\b|--exclude-dir|--exclude=|-not\s+-path", cmd):
    sys.exit(0)

home = os.path.realpath(os.path.expanduser("~"))
anchor = r"(?:~|\$HOME|\$\{HOME\}|" + re.escape(home) + r")"
# Backslash-escaped spaces are part of the path: the leak was written
# ~/Queens\ College\ Dropbox, and stopping at the first space missed it.
# Backslash is excluded from the class on purpose. Left in, it was consumed
# there and the escaped-space alternative never got a chance, so
# ~/Queens\ College\ Dropbox captured only as "~/Queens\" and the real leak
# went undetected. Now a backslash can only be matched by "\\ ".
body = r"(?:[^\s\"'\''|;&()\\]|\\ )*"

cands = re.findall(anchor + body, cmd)
cands += re.findall(r"\"(" + anchor + r"[^\"]*)\"", cmd)
cands += re.findall(r"'\''(" + anchor + r"[^'\'']*)'\''", cmd)

for raw in cands:
    p = raw.replace("${HOME}", home).replace("$HOME", home).replace("\\ ", " ")
    if p.startswith("~"):
        p = home + p[1:]
    p = os.path.normpath(p).rstrip("/")
    if p == home:
        print(p)
        sys.exit(1)
    if not p.startswith(home + os.sep):
        continue
    parts = p[len(home) + 1:].split(os.sep)
    if "Dropbox" in parts[0] and len(parts) <= 4:
        print(p)
        sys.exit(1)
sys.exit(0)
' || true)

if [ -n "${search_root:-}" ]; then
    category="a recursive search rooted at a directory that holds protected material"
    guidance="The root ${search_root} is an ancestor of personnel and student-record trees, so this search would walk them and surface them in its output even though the command names nothing protected. That is how a colleague's promotion folder reached a transcript on 2026-09-07. Search the specific directory you actually need, or pass -prune / --exclude-dir for the protected names if a broad sweep is genuinely required."
fi

# --- Guard 1: the command names a protected path ----------------------------
if [ -z "$category" ]; then
case "$command_text" in
    */EmployeeInfo*|*EmployeeInfo/*|*/TenureFile*|*TenureFile/*)
        category="personnel material"
        guidance="Personnel files are off limits without an explicit, specific instruction from Dax. If he has asked for this, have him run the command himself with the ! prefix, or ask him to confirm in this turn before retrying."
        ;;
    # Slash-anchored, like the branches above. The first draft of this branch
    # matched the bare words and promptly blocked its own commit message, which
    # only described the directories. That is the same mistake the note above
    # records from 2026-08-02; it is easy to repeat.
    *"/SEES P&B"*|*"/SEES reappointments"*|*"Promotion Folder/"*|*"Promotion folder/"*|*"/reappointments/"*)
        category="another person's personnel material"
        guidance="Promotion and reappointment files belong to colleagues, not to Dax, so they are not his to share and no instruction from him unlocks them here. Do not read, list, copy or search them. If a name or a date is needed, ask him for the fact rather than the file."
        ;;
    */accommodations*|*accommodations/*|*/finalGrades*|*finalGrades/*)
        category="protected student records"
        guidance="Accommodations and final-grade records are FERPA-protected and never enter this conversation, per the standing student-data rule. Aggregate counts are fine because they identify no one; the files are not. Grading routes through CUNY Copilot on de-identified work."
        ;;
    */_NONPUBLIC_copilot_only*|*_NONPUBLIC_copilot_only/*)
        category="non-public institutional material"
        guidance="This path is marked Copilot-only. Under CUNY's Data Classification Standard, non-public, internal, and sensitive university data goes to Microsoft 365 Copilot via CUNY Login, which is the licensed and approved service. Do the language work there. If code or automation is needed, write the script and have Dax run it locally on the file."
        ;;
    */_EMBARGOED_do_not_access*|*_EMBARGOED_do_not_access/*)
        category="embargoed course material"
        guidance="Embargoed directories are never read. This is a hard rule, not a per-conversation judgment call."
        ;;
    *)
        exit 0
        ;;
esac
fi

reason=$(printf 'copilot-firewall (PreToolUse hook, Bash): blocked.\n\nThe command references %s:\n\n  %s\n\n%s\n\nNote for the model: permissions.deny does not cover Bash, which is why this hook exists. Do not work around it with a different shell invocation, a Python one-liner, or a copy to another path.' \
    "$category" "$command_text" "$guidance")

python3 -c 'import json, sys
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": sys.stdin.read(),
    }
}))
' <<< "$reason"
