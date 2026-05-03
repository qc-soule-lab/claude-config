#!/usr/bin/env bash
# SessionStart hook: check MEMORY.md indexes in every project-scoped memory
# dir for drift. Flags two failure modes:
#   - Orphans: .md files present on disk but not referenced in MEMORY.md.
#   - Broken links: MEMORY.md references a .md file that does not exist.
#
# Silent when everything is in sync.

set -euo pipefail
cat >/dev/null 2>&1 || true

PROJECTS_BASE="$HOME/.claude/projects"
[ -d "$PROJECTS_BASE" ] || exit 0

# Claude Code encodes absolute paths into project dir names by replacing every
# "/" with "-". E.g. /home/jovyan -> -home-jovyan.
HOME_ENCODED="-${HOME//\//-}"
HOME_ENCODED="${HOME_ENCODED#-}"
HOME_ENCODED="-${HOME_ENCODED}"

# specKitScience-encoded base used to glob umbrella + sub-repo memory dirs.
SPECKIT_ENCODED="${HOME_ENCODED}-repos-specKitScience"

check_dir() {
  local memory_dir="$1"
  [ -f "$memory_dir/MEMORY.md" ] || return 0

  local files_on_disk
  files_on_disk=$(find "$memory_dir" -maxdepth 1 -type f -name '*.md' ! -name 'MEMORY.md' -printf '%f\n' 2>/dev/null | LC_ALL=C sort)

  local files_in_index
  files_in_index=$(grep -oE '\(([a-zA-Z0-9_./\-]+\.md)\)' "$memory_dir/MEMORY.md" 2>/dev/null \
    | tr -d '()' \
    | grep -v '^MEMORY\.md$' \
    | LC_ALL=C sort -u || true)

  local orphans broken
  orphans=$(comm -23 <(printf '%s\n' "$files_on_disk") <(printf '%s\n' "$files_in_index") | grep -v '^$' || true)
  broken=$(comm -13 <(printf '%s\n' "$files_on_disk") <(printf '%s\n' "$files_in_index") | grep -v '^$' || true)

  if [ -n "$orphans" ] || [ -n "$broken" ]; then
    local dir_short="${memory_dir#$HOME/}"
    printf '=== %s ===\n' "$dir_short"
    if [ -n "$orphans" ]; then
      printf '  Orphaned (on disk, not in MEMORY.md):\n'
      printf '%s\n' "$orphans" | sed 's/^/    - /'
    fi
    if [ -n "$broken" ]; then
      printf '  Broken links (in MEMORY.md, not on disk):\n'
      printf '%s\n' "$broken" | sed 's/^/    - /'
    fi
  fi
}

drift_output=$(
  check_dir "$PROJECTS_BASE/${HOME_ENCODED}/memory"
  for memdir in "$PROJECTS_BASE/${SPECKIT_ENCODED}"*/memory/; do
    [ -d "$memdir" ] || continue
    check_dir "${memdir%/}"
  done
)

[ -z "$drift_output" ] && exit 0

context=$(printf 'MEMORY.md index-sync check (SessionStart hook) found drift. Either .md files exist on disk but are not indexed (orphans), or MEMORY.md entries point at files that do not exist (broken links). Fix by updating the relevant MEMORY.md, or by deleting stale files.\n\n%s\n' "$drift_output")

python3 -c '
import json, sys
ctx = sys.stdin.read()
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": ctx,
    }
}))
' <<< "$context"
