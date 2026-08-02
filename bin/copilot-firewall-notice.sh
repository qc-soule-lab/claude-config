#!/usr/bin/env bash
# PreToolUse hook: once per session, when work first touches a proposal,
# report, or forms bucket, inject a reminder about where non-public drafts and
# vendor pricing belong.
#
# A notice, not a block. Those buckets hold Dax's own draft work, which he
# routinely wants edited here; the point is that crossing into non-public
# institutional material should be deliberate rather than incidental. Hard
# blocks live in permissions.deny plus copilot-firewall-bash.sh.
#
# Fires at most once per session (sentinel keyed by session_id) so it does not
# become noise that gets ignored.

set -euo pipefail

payload=$(cat)

parsed=$(printf '%s' "$payload" | python3 -c 'import json, sys
try:
    p = json.load(sys.stdin)
except Exception:
    sys.exit(0)
ti = p.get("tool_input", {}) or {}
fields = [ti.get(k, "") for k in ("file_path", "path", "pattern", "command", "notebook_path")]
print(p.get("session_id", "nosession"))
print(" ".join(str(f) for f in fields if f).replace("\n", " "))')

session_id=$(printf '%s\n' "$parsed" | sed -n 1p)
target=$(printf '%s\n' "$parsed" | sed -n 2p)

[ -z "${target:-}" ] && exit 0

case "$target" in
    *proposal_dev*|*report_dev*|*forms_dev*)
        ;;
    *)
        exit 0
        ;;
esac

sentinel_dir="${TMPDIR:-/tmp}/claude-copilot-firewall"
mkdir -p "$sentinel_dir"
sentinel="$sentinel_dir/notice-${session_id:-nosession}"
[ -e "$sentinel" ] && exit 0
: > "$sentinel"

reason='copilot-firewall (PreToolUse hook, first touch this session):

This is a proposal, report, or forms bucket. Two reminders before working here.

1. WHERE THE WORK BELONGS. Under CUNY'"'"'s Data Classification Standard, non-public, internal, and sensitive university data goes to Microsoft 365 Copilot via CUNY Login, the only licensed GenAI service approved for it. Pre-decisional drafts and vendor pricing (quotes, discounts, payment terms) are the categories that actually land there. Prefer: Claude builds the tooling and verifies the numbers; Copilot does language work on non-public prose; Dax runs scripts locally.

2. WHAT IS FINE HERE. Anything already public or self-published: the posted CV, published papers, posted syllabi, public data, and vendor part numbers that appear in a submitted budget. Settled with Dax 2026-08-02, see memory cuny_ai_tool_guidance.

Park anything that should never reach a non-CUNY tool in a _NONPUBLIC_copilot_only/ directory, which is hard-denied.

This notice fires once per session and does not block anything.'

python3 -c 'import json, sys
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "additionalContext": sys.stdin.read(),
    }
}))
' <<< "$reason"
