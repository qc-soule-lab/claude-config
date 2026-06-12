#!/usr/bin/env bash
# PreToolUse(Bash git commit) hook — the lab's mechanical pre-commit gate.
# Enforces three rules that prose alone kept missing (~20% miss rates per memory):
#   1. pytest must pass (if the repo has pyproject.toml + tests/)
#   2. constitution.md edits must ship with a regenerated PDF
#   3. newly added figures need their rubric scorecard touched in the same commit
# exit 2 = block the commit and feed the message back to Claude. exit 0 = allow.
set -uo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
[ -z "$repo_root" ] && exit 0
cd "$repo_root"

staged="$(git diff --cached --name-only 2>/dev/null || true)"
[ -z "$staged" ] && exit 0

# --- 1. pytest gate -----------------------------------------------------------
if [ -f pyproject.toml ] && [ -d tests ]; then
  if ! uv run pytest -q -x >/tmp/precommit_pytest.log 2>&1; then
    {
      echo "BLOCKED: uv run pytest fails — the lab rule is pytest-green before every commit."
      echo "Last lines:"
      tail -15 /tmp/precommit_pytest.log
      echo "Fix the code (never skip/disable tests to pass), then commit."
    } >&2
    exit 2
  fi
fi

# --- 2. constitution PDF sync ---------------------------------------------------
if printf '%s\n' "$staged" | grep -q '\.specify/memory/constitution\.md$'; then
  if ! printf '%s\n' "$staged" | grep -qiE '\.pdf$'; then
    {
      echo "BLOCKED: .specify/memory/constitution.md is staged but no regenerated PDF is."
      echo "Regenerate (canonical: uv run python scripts/make_doc_pdf.py .specify/memory/constitution.md)"
      echo "and stage the PDF alongside the markdown — they must never drift."
    } >&2
    exit 2
  fi
fi

# --- 3. new figures need a rubric scorecard touch -------------------------------
new_figs="$(git diff --cached --name-only --diff-filter=A 2>/dev/null \
  | grep -E '^outputs/figures/.*\.(png|pdf|svg)$' || true)"
if [ -n "$new_figs" ]; then
  if ! printf '%s\n' "$staged" | grep -qE 'specs/(map|timeseries)-scorecard\.md$'; then
    {
      echo "BLOCKED: new figure(s) staged without a rubric scorecard update:"
      printf '%s\n' "$new_figs" | head -5
      echo "Run the /map-figure or /timeseries-figure rubric, record P/F/- in"
      echo "specs/map-scorecard.md or specs/timeseries-scorecard.md, and stage it too."
    } >&2
    exit 2
  fi
fi

exit 0
