#!/usr/bin/env bash
# Idempotent installer: symlinks portable config from this repo into ~/.claude/
# and seeds settings.json / settings.local.json from templates if missing.
#
# Safe to re-run. Existing real settings files are NEVER overwritten.

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.claude"

mkdir -p "$TARGET"

echo "Installing from: $REPO"
echo "Target:         $TARGET"
echo

# Symlink CLAUDE.md
if [ -f "$REPO/CLAUDE.md" ]; then
  ln -sfn "$REPO/CLAUDE.md" "$TARGET/CLAUDE.md"
  echo "  symlink: CLAUDE.md"
fi

# Symlink directories that hold portable definitions.
for d in skills bin agents commands; do
  if [ -d "$REPO/$d" ]; then
    ln -sfn "$REPO/$d" "$TARGET/$d"
    echo "  symlink: $d/"
  fi
done

# Symlink optional top-level files if present.
for f in keybindings.json statusline.sh; do
  if [ -e "$REPO/$f" ]; then
    ln -sfn "$REPO/$f" "$TARGET/$f"
    echo "  symlink: $f"
  fi
done

# Seed settings.json from template, but never overwrite an existing one.
seed_template() {
  local template="$1" target="$2"
  if [ ! -e "$REPO/$template" ]; then
    return 0
  fi
  if [ -e "$target" ]; then
    echo "  keep:    $target (already exists; not overwriting)"
  else
    cp "$REPO/$template" "$target"
    echo "  copy:    $template -> $target"
  fi
}

seed_template "settings.example.json"       "$TARGET/settings.json"
seed_template "settings.local.example.json" "$TARGET/settings.local.json"

echo
echo "Done."
echo
echo "Next steps:"
echo "  1. Review $TARGET/settings.json — confirm hook commands resolve."
echo "  2. Add per-machine permission grants to $TARGET/settings.local.json."
echo "  3. Start a new Claude Code session; SessionStart hooks should fire."
