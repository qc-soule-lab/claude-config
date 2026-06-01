#!/usr/bin/env bash
# Generate a per-member onboarding repo from the template, fill in their details,
# and optionally create it under the qc-soule-lab org (via gh) and invite the member.
#
# Usage:
#   make-onboard-repo.sh <name> --project-repo <git-url> --container <name> \
#                        [--github-user <login>] [--org qc-soule-lab] \
#                        [--claude-config-url <url>] [--create]
#
#   --create        also: create the private repo under the org via gh, push, and
#                   (if --github-user given) invite them with push access.
# Without --create it just produces the repo locally for you to review.
set -euo pipefail

NAME=""; PROJECT_REPO=""; CONTAINER=""; GH_USER=""; ORG="qc-soule-lab"; ROLE="student"
CLAUDE_CONFIG_URL="https://github.com/qc-soule-lab/claude-config.git"
CREATE=0
NAME="${1:-}"; shift || true
while [ $# -gt 0 ]; do
  case "$1" in
    --project-repo) PROJECT_REPO="$2"; shift 2;;
    --container) CONTAINER="$2"; shift 2;;
    --github-user) GH_USER="$2"; shift 2;;
    --org) ORG="$2"; shift 2;;
    --role) ROLE="$2"; shift 2;;
    --claude-config-url) CLAUDE_CONFIG_URL="$2"; shift 2;;
    --create) CREATE=1; shift;;
    *) echo "unknown arg: $1" >&2; exit 2;;
  esac
done
[ -n "$NAME" ] && [ -n "$PROJECT_REPO" ] && [ -n "$CONTAINER" ] || {
  echo "usage: make-onboard-repo.sh <name> --project-repo <url> --container <name> [--role student|collaborator] [--github-user <login>] [--create]" >&2
  exit 2; }

SLUG="$(printf '%s' "$NAME" | tr '[:upper:] ' '[:lower:]-' | tr -cd 'a-z0-9-' | sed 's/--*/-/g; s/^-//; s/-$//')"
CFG="$(cd "$(dirname "$0")/.." && pwd)"
case "$ROLE" in
  student)      TPL="$CFG/onboarding/templates/onboard";;
  collaborator) TPL="$CFG/onboarding/templates/onboard-collaborator";;
  *) echo "error: --role must be 'student' or 'collaborator'" >&2; exit 2;;
esac
OUT="$HOME/repos/onboard-$SLUG"

[ -d "$OUT" ] && { echo "error: $OUT already exists" >&2; exit 1; }
cp -r "$TPL" "$OUT"

# Fill placeholders.
esc() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }
for f in "$OUT"/*.md; do
  sed -i \
    -e "s/{{NAME}}/$(esc "$NAME")/g" \
    -e "s/{{SLUG}}/$(esc "$SLUG")/g" \
    -e "s/{{ORG}}/$(esc "$ORG")/g" \
    -e "s/{{PROJECT_REPO}}/$(esc "$PROJECT_REPO")/g" \
    -e "s/{{CONTAINER}}/$(esc "$CONTAINER")/g" \
    -e "s/{{CLAUDE_CONFIG_URL}}/$(esc "$CLAUDE_CONFIG_URL")/g" \
    "$f"
done

( cd "$OUT" && git init -q -b main && git add -A && git commit -q -m "Onboarding repo for $NAME" )
echo "generated: $OUT"

if [ "$CREATE" = "1" ]; then
  command -v gh >/dev/null 2>&1 || { echo "error: gh not installed; cannot --create" >&2; exit 1; }
  ( cd "$OUT" && gh repo create "$ORG/onboard-$SLUG" --private --source=. --push )
  echo "created + pushed: github.com/$ORG/onboard-$SLUG"
  if [ -n "$GH_USER" ]; then
    gh api -X PUT "/repos/$ORG/onboard-$SLUG/collaborators/$GH_USER" -f permission=push >/dev/null \
      && echo "invited $GH_USER (push access)"
  fi
fi

echo ""
echo "Next: provision their Azure container + SAS (must match CONTAINER=$CONTAINER), then hand them the onboard URL:"
echo "  python3 $CFG/onboarding/provision-student-azure.py ${CONTAINER#*-} --project ${CONTAINER%%-*}"
echo "  (deliver ~/.azure/handoff/$CONTAINER.env securely; they save it as ~/.azure/$CONTAINER.env)"
