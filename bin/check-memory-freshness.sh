#!/usr/bin/env bash
# SessionStart hook: flag repos with activity newer than the newest write in
# their corresponding memory dir.
#
# Reads a JSON payload on stdin (ignored — SessionStart carries no useful fields).
#
# Logic:
#   1. Each sub-repo that has its own project-scoped memory dir
#      (e.g., noaa-bravoseis, magma2vents, miso-my-analysis, my-analysis-tmpsf)
#      is compared against its own memory.
#   2. The umbrella specKitScience memory covers every sub-repo that does NOT
#      have its own memory dir.
#
# Emits JSON with hookSpecificOutput.additionalContext if any repo's newest file
# is more than THRESHOLD_SECONDS older than the newest memory write in its
# corresponding memory dir. Silent otherwise.

set -euo pipefail

cat >/dev/null 2>&1 || true  # drain stdin

PROJECTS_BASE="$HOME/.claude/projects"
REPOS_DIR="$HOME/repos/specKitScience"

# Claude Code encodes absolute paths into project dir names by replacing every
# "/" with "-". Build the encoded prefix that matches $REPOS_DIR on this host.
REPOS_ENCODED="-${REPOS_DIR//\//-}"
REPOS_ENCODED="${REPOS_ENCODED#-}"
REPOS_ENCODED="-${REPOS_ENCODED}"

UMBRELLA_MEMDIR="$PROJECTS_BASE/${REPOS_ENCODED}/memory"
THRESHOLD_SECONDS=3600      # 60 min — tolerate forgetting for an hour
MAX_PROJECTS_REPORTED=5

[ -d "$REPOS_DIR" ] || exit 0

# Helper: newest mtime (epoch seconds) of .md files in $1, or empty if none.
newest_memory_mtime() {
  find "$1" -maxdepth 1 -type f -name '*.md' -printf '%T@\n' 2>/dev/null \
    | awk -F. '{print $1}' | sort -n | tail -1
}

# Helper: newest mtime of any non-trivial file under $1.
newest_repo_mtime() {
  find "$1" -type f \
    -not -path '*/.git/*' \
    -not -path '*/node_modules/*' \
    -not -path '*/.venv/*' \
    -not -path '*/venv/*' \
    -not -path '*/__pycache__/*' \
    -not -path '*/.ipynb_checkpoints/*' \
    -not -path '*/.claude/*' \
    -printf '%T@\n' 2>/dev/null | awk -F. '{print $1}' | sort -n | tail -1
}

# Build map: encoded-repo-name -> repo absolute path.
# Encoding: basename's underscores become hyphens (matches Claude Code's
# project-dir path encoding for path components below $HOME).
declare -A repo_path_by_encoded=()
shopt -s nullglob
for repo in "$REPOS_DIR"/*/; do
  repo_name=$(basename "$repo")
  encoded="${repo_name//_/-}"
  repo_path_by_encoded[$encoded]="$repo"
done

# Find all sub-repo memory dirs (everything under
# projects/${REPOS_ENCODED}-* that has a memory/ subdir).
declare -A sub_repo_memdir_by_encoded=()
for memdir in "$PROJECTS_BASE/${REPOS_ENCODED}"-*/; do
  [ -d "${memdir}memory" ] || continue
  project_name=$(basename "$memdir")
  encoded_repo="${project_name#${REPOS_ENCODED}-}"
  sub_repo_memdir_by_encoded[$encoded_repo]="${memdir}memory"
done

declare -a stale_lines=()

# 1) For each sub-repo that has its own memory, compare sub-repo vs its memory.
for encoded in "${!sub_repo_memdir_by_encoded[@]}"; do
  repo_path="${repo_path_by_encoded[$encoded]:-}"
  [ -z "$repo_path" ] && continue  # memory exists but repo doesn't (stale orphan)
  memory_dir="${sub_repo_memdir_by_encoded[$encoded]}"

  mem_newest=$(newest_memory_mtime "$memory_dir")
  [ -z "${mem_newest:-}" ] && continue

  repo_newest=$(newest_repo_mtime "$repo_path")
  [ -z "${repo_newest:-}" ] && continue

  diff=$(( repo_newest - mem_newest ))
  if [ "$diff" -gt "$THRESHOLD_SECONDS" ]; then
    hours=$(( diff / 3600 ))
    stale_lines+=("$(basename "$repo_path") (${hours}h newer than its own memory)")
  fi
done

# 2) For the umbrella memory, compare every sub-repo WITHOUT its own memory.
if [ -d "$UMBRELLA_MEMDIR" ]; then
  umbrella_newest=$(newest_memory_mtime "$UMBRELLA_MEMDIR")
  if [ -n "${umbrella_newest:-}" ]; then
    for repo in "$REPOS_DIR"/*/; do
      repo_name=$(basename "$repo")
      encoded="${repo_name//_/-}"
      [ -n "${sub_repo_memdir_by_encoded[$encoded]:-}" ] && continue  # handled above

      repo_newest=$(newest_repo_mtime "$repo")
      [ -z "${repo_newest:-}" ] && continue

      diff=$(( repo_newest - umbrella_newest ))
      if [ "$diff" -gt "$THRESHOLD_SECONDS" ]; then
        hours=$(( diff / 3600 ))
        stale_lines+=("$repo_name (${hours}h newer than umbrella memory)")
      fi
    done
  fi
fi

[ "${#stale_lines[@]}" -eq 0 ] && exit 0

reported=$(printf '%s\n' "${stale_lines[@]}" \
  | sort -t'(' -k2 -nr \
  | head -n "$MAX_PROJECTS_REPORTED")

context=$(printf 'Memory-freshness check (SessionStart hook): the following repos have file activity newer than the newest write in their corresponding memory. If the prior session did work in any of these that is not reflected in memory, proactively ask the user what happened and update the project memory file before starting new work.\n\n%s\n' \
  "$reported")

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
