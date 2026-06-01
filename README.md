# claude-config

Portable Claude Code configuration: `CLAUDE.md`, skills, and hook scripts that
ride between machines. Auto-memory and session state are intentionally
**excluded** — they stay per-machine.

This repo is **private** by policy. `CLAUDE.md` references active research
projects and collaborators; the hook scripts encode workflow assumptions; do
not make this repo public without scrubbing both.

## What's in

| Path | Purpose |
|---|---|
| `CLAUDE.md` | Global Claude Code instructions (parallel-worker cap, AI-disclosure rules, package preferences, testing, memory hygiene, ethical-check standard) |
| `skills/` | User-defined skills: `ethical-check`, `figure-standards`, `map-figure`, `timeseries-figure` |
| `bin/` | Shell hook scripts wired up via `settings.json` (memory freshness/index-sync checks, project memory listing, ethical-check WebFetch gate, post-commit reminder) |
| `settings.example.json` | Hooks configuration template. Copy to `settings.json` per machine. |
| `settings.local.example.json` | Minimal permissions allowlist. Copy to `settings.local.json` and grow per machine. |
| `install.sh` | Idempotent symlink installer |

## What's deliberately out (and why)

- **`projects/`** — Auto-memory directories with active research notes, collaborator names, and methodology drafts. HIGH sensitivity. By design, switching machines means losing per-conversation memory continuity; that's the correct tradeoff.
- **`sessions/`, `history.jsonl`** — Conversation transcripts. Sensitive and not meaningful out of context.
- **`.credentials.json`** — OAuth / API tokens. Hard exclude.
- **`settings.json`, `settings.local.json`** — The real ones. Per-machine state. Templates only in this repo.
- **`cache/`, `paste-cache/`, `file-history/`, `telemetry/`, `session-env/`, `shell-snapshots/`, `backups/`, `downloads/`, `debug/`, `tasks/`, `todos/`, `plans/`, `plugins/`, `statsig/`, `mcp-needs-auth-cache.json`, `stats-cache.json`** — Runtime state. Regenerated automatically.

## Install

```bash
# On each machine:
git clone git@github.com:qc-soule-lab/claude-config.git ~/repos/claude-config
cd ~/repos/claude-config
./install.sh
```

The installer:
1. Symlinks `CLAUDE.md`, `skills/`, and `bin/` from this repo into `~/.claude/`.
2. Copies `settings.example.json` → `~/.claude/settings.json` (only if it doesn't already exist).
3. Copies `settings.local.example.json` → `~/.claude/settings.local.json` (only if it doesn't already exist).
4. Reports what it did.

Symlinks (rather than copies) are used for `CLAUDE.md`, `skills/`, `bin/` so
edits propagate back to git automatically. Settings files are copied because
they're per-machine state.

## Auto-memory tradeoff

The `~/.claude/projects/` directory holds Claude Code's persistent memory:
collaborator names, project state, prior decisions, accumulated feedback. It
is **not** synced through this repo.

Consequence: starting Claude Code on the second machine gives you a "cold"
agent. It has the global `CLAUDE.md` instructions and the skills, but no
project-specific memory of BRAVOSEIS, scaleworm, etc. Memory will rebuild as
you work. This is the correct tradeoff — the alternative (committing
`projects/` to git) leaks active research context.

If you ever need to migrate memory between machines manually, `rsync` the
relevant subdirectory of `~/.claude/projects/` directly between hosts;
do not route through this repo.

## Portability notes

- Hook scripts under `bin/` derive paths from `$HOME` at runtime, so they work
  on any user account (not just `jovyan`).
- `check-memory-freshness.sh` assumes `~/repos/specKitScience/` exists; it
  silently no-ops on machines where that path is absent.
- `settings.example.json` uses `$HOME` (shell-expanded) in hook command paths.
