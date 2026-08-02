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
#   EmployeeInfo, TenureFile        personnel material (Dropbox)
#   _NONPUBLIC_copilot_only         non-public institutional material; per CUNY
#                                   policy this belongs in CUNY Copilot, the only
#                                   licensed GenAI service approved for
#                                   non-public, internal, and sensitive data
#   _EMBARGOED_do_not_access        course embargo (matches the existing denies)
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
# the test itself). Put the payloads in a file and run that. See the scratchpad
# script written 2026-08-02.
case "$command_text" in
    */EmployeeInfo*|*EmployeeInfo/*|*/TenureFile*|*TenureFile/*)
        category="personnel material"
        guidance="Personnel files are off limits without an explicit, specific instruction from Dax. If he has asked for this, have him run the command himself with the ! prefix, or ask him to confirm in this turn before retrying."
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
