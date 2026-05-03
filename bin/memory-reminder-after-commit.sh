#!/usr/bin/env bash
# PostToolUse hook for Bash(git commit:*): after a successful git commit,
# inject a reminder to update the relevant project memory with commit hash,
# change summary, and next step.
#
# Silent for non-commit Bash calls and failed commits (detected by absence
# of the standard git-commit success signature "[<branch> <hash>] ..." in
# stdout).

set -euo pipefail

payload=$(cat)

parsed=$(printf '%s' "$payload" | python3 -c '
import json, sys
try:
    p = json.load(sys.stdin)
    tool_name = p.get("tool_name", "")
    tool_input = p.get("tool_input", {}) or {}
    tool_response = p.get("tool_response", {}) or {}
    command = tool_input.get("command", "")
    stdout = tool_response.get("stdout", "") if isinstance(tool_response, dict) else ""
    cmd_stripped = command.strip()
    is_commit = 1 if (cmd_stripped.startswith("git commit") or " git commit" in command) else 0
    print(f"TOOL={tool_name}")
    print(f"IS_COMMIT={is_commit}")
    print("---STDOUT---")
    print(stdout)
except Exception:
    sys.exit(0)
')

tool_name=$(printf '%s' "$parsed" | grep -m1 '^TOOL=' | cut -d= -f2-)
is_commit=$(printf '%s' "$parsed" | grep -m1 '^IS_COMMIT=' | cut -d= -f2-)
stdout=$(printf '%s' "$parsed" | sed -n '/^---STDOUT---$/,$p' | tail -n +2)

[ "$tool_name" = "Bash" ] || exit 0
[ "$is_commit" = "1" ] || exit 0

# Check for the git-commit success signature: a line starting with "[<branch> <hash>]".
# If not present, the commit failed (hook fails silent — nothing to remind about).
if ! printf '%s' "$stdout" | grep -qE '^\[[^]]+ [a-f0-9]{7,}\]'; then
  exit 0
fi

hash_short=$(printf '%s' "$stdout" \
  | grep -oE '^\[[^]]+ [a-f0-9]{7,}\]' \
  | grep -oE '[a-f0-9]{7,}' \
  | head -1)

context=$(printf 'Post-commit reminder (hook): a git commit just succeeded%s. Update the relevant project-scoped memory file NOW, before starting the next task:\n\n  1. Add the commit hash and a one-line summary of what changed.\n  2. State what the next concrete step is.\n  3. If the work is in a repo that has its own project-scoped memory dir (noaa-bravoseis, magma2vents, miso-my-analysis, my-analysis-tmpsf, or the specKitScience umbrella), write there; otherwise the global memory.\n\nIf the commit was trivial (typo, whitespace, doc wording), decide consciously to skip — do not skip because you forgot.' \
    "${hash_short:+ ($hash_short)}")

python3 -c '
import json, sys
ctx = sys.stdin.read()
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PostToolUse",
        "additionalContext": ctx,
    }
}))
' <<< "$context"
