#!/usr/bin/env bash
# qc-soule-lab — one-shot student environment bootstrap (uv-based, mirrors the PI's setup).
# Run from INSIDE the student's project repo (the dir with — or that should get — a pyproject.toml).
# Safe to re-run. No conda: uv handles project deps; ffmpeg is system-wide; default node is CPU.
set -euo pipefail
ROLE="student"
[ "${1:-}" = "--role" ] && ROLE="${2:-student}"
case "$ROLE" in student|collaborator) ;; *) echo "error: --role must be student|collaborator" >&2; exit 2;; esac
echo "== qc-soule-lab member bootstrap (role: $ROLE) =="

# 1) uv — project + tool manager
if ! command -v uv >/dev/null 2>&1; then
  echo "[1/5] installing uv ..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
else
  echo "[1/5] uv present: $(uv --version)"
fi

# 2) lab Claude config — skills (incl. ethical-check), hooks, CLAUDE.md, student settings
#    NOTE: switch the URL to qc-soule-lab/claude-config once the repo is transferred into the org.
CFG="$HOME/repos/claude-config"
[ -d "$CFG" ] || git clone https://github.com/daxsoule/claude-config.git "$CFG"
mkdir -p "$HOME/.claude"
# seed the STUDENT settings first so install.sh won't overwrite it with the generic template
[ -f "$HOME/.claude/settings.json" ] || cp "$CFG/settings.$ROLE.example.json" "$HOME/.claude/settings.json"
( cd "$CFG" && ./install.sh )
echo "[2/5] lab Claude config installed (skills + hooks + CLAUDE.md + student settings)"

# 3) SpecKit — same source the PI uses (science-specify init/check/version)
echo "[3/5] installing SpecKit (science-specify) ..."
uv tool install --force git+https://github.com/Waveform-Analytics/science-spec-kit.git

# 4) project deps via uv + Jupyter kernel
if [ ! -f pyproject.toml ]; then
  echo "[4/5] no pyproject.toml here — seeding from the lab template"
  cp "$CFG/pyproject.student.example.toml" pyproject.toml
fi
uv sync
PROJ="$(basename "$PWD")"
uv run python -m ipykernel install --user --name "$PROJ" --display-name "Python ($PROJ)"
echo "[4/5] uv sync complete; Jupyter kernel 'Python ($PROJ)' registered"

# 5) Azure derived-data CLI (azure_lake) — deploy from the baseline onto PATH.
#    Per-student container + SAS are provisioned separately by Dr. Soule.
echo "[5/5] installing azure_lake ..."
mkdir -p "$HOME/.local/bin"
ln -sfn "$CFG/tools/azure_lake" "$HOME/.local/bin/azure_lake"
# azure_lake's one dependency. This is a GLOBAL helper CLI, not project deps —
# the only sanctioned 'pip install' exception to the lab's uv-only rule.
python3 -m pip install --user --quiet azure-storage-blob \
  || echo "  (could not install azure-storage-blob automatically — ask Dr. Soule)"
echo "      azure_lake ready. Put your per-student SAS at ~/.azure/<container>.env (Dr. Soule provides it)."

echo ""
echo "== done =="
echo "Next:"
echo "  - 'science-specify init' if this repo is not yet SpecKit-scaffolded (gives /speckit.* commands)."
echo "  - 'science-specify check' to verify required tools."
echo "  - Authenticate Claude Code under your qc-soule-lab Team seat."
