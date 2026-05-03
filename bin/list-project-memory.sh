#!/usr/bin/env bash
# SessionStart hook: surface project-scoped memory dirs that exist on this
# machine so Claude knows to read them when the user references a repo —
# even if the session started from a cwd that didn't auto-load them.
#
# Fires on every SessionStart. Silent (exit 0 with no output) if no
# project-scoped memory dirs beyond the default $HOME-encoded global one exist.

set -euo pipefail

# Drain stdin (SessionStart JSON payload; we don't need any fields from it)
cat >/dev/null 2>&1 || true

PROJECTS_DIR="$HOME/.claude/projects"
[ -d "$PROJECTS_DIR" ] || exit 0

# Claude Code encodes absolute paths into project dir names by replacing every
# "/" with "-". E.g. /home/jovyan -> -home-jovyan, /Users/dax -> -Users-dax.
HOME_ENCODED="-${HOME//\//-}"
HOME_ENCODED="${HOME_ENCODED#-}"
HOME_ENCODED="-${HOME_ENCODED}"

# Collect project dirs that contain a memory/MEMORY.md, excluding the default
# global one (which Claude Code auto-loads when cwd is $HOME).
declare -a lines=()
shopt -s nullglob
for proj in "$PROJECTS_DIR"/*/; do
  name=$(basename "$proj")
  [ "$name" = "$HOME_ENCODED" ] && continue
  [ -f "${proj}memory/MEMORY.md" ] || continue

  newest=$(find "${proj}memory" -maxdepth 1 -type f -name '*.md' \
    -printf '%TY-%Tm-%Td\n' 2>/dev/null | sort | tail -1)
  count=$(find "${proj}memory" -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l)
  lines+=("$(printf -- '- `%s/` — %s files, newest write %s' "$name" "$count" "${newest:-unknown}")")
done

[ "${#lines[@]}" -eq 0 ] && exit 0

header='Project-scoped memory directories on this machine (NOT auto-loaded unless session cwd is inside the matching repo tree). Before claiming you have no memory of a project the user references, read the MEMORY.md inside the matching dir:'

printf -v body '%s\n' "${lines[@]}"
context=$(printf '%s\n\n%s' "$header" "$body")

# Emit JSON so Claude Code injects the message into the session context.
# python3 used for safe JSON escaping (jq not guaranteed on PATH).
python3 -c '
import json, sys
ctx = sys.stdin.read()
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": ctx,
    }
}))
' <<<"$context"
