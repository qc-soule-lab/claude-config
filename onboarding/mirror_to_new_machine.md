*AI-drafted setup brief. Reviewed and approved by the instructor. For use when bringing a new Mac (or any new machine) into the lab's three-machine landscape: Hub (JupyterHub), Laptop, Desktop.*

# Mirror an existing Mac setup to a new machine

This brief is intended to be pasted into a fresh Claude Code session on the **target** machine. It assumes a "source" machine (laptop or desktop) is already configured. The source machine produces two tarballs; the target machine ingests them and clones the repos.

## Path translation between Macs

Hostname-based home directories differ across the three machines:

| Machine | `$HOME` |
|---|---|
| Hub (JupyterHub) | `/home/jovyan` |
| Laptop | `/Users/dax` |
| Desktop | `/Users/daxsoule` |

When migrating memory or any file that hardcodes paths, translate the source `$HOME` to the target `$HOME`.

## End state on the target machine

1. Memory at `~/.claude/projects/-Users-<homename>/memory/` matching the source's memory (with path translation).
2. Global CLAUDE.md at `~/.claude/CLAUDE.md` as a symlink to `~/repos/claude-config/CLAUDE.md`.
3. Repos under `~/repos/` organized into five buckets:
   - `class_dev/` — course development (currently: `geol-333-fall-2026`, `geol-393-fall-2026`, `geol-795-makayla-fall-2026`, `ocean540_guest_lecture`).
   - `forms_dev/` — university forms (currently: `qc_forms`).
   - `loc_science_dev/` — local-machine science (currently on Mac: `ctdMAB_my-analysis`, `joseph-scaleworm-thesis`; `bravoseis_orca_3d` lives at this same bucket path on the Hub but the actual analysis runs on JupyterHub, so do not clone it on a Mac by default).
   - `meeting_dev/` — meeting prep (currently: `OOIFB_May2026_Plan`, local-only).
   - `report_dev/` — formal reports (currently: `expense_reports`, `sabbatical_reports`).
   - Plus `claude-config` and `dotfiles` at the `repos/` root (infra).
4. Azure data-lake access: `~/.azure/*.env` per-container SAS files, `azure_lake` helper symlinked to `~/repos/claude-config/tools/azure_lake`.
5. JupyterLab installed inside `class_dev/ocean540_guest_lecture/.venv`; terminal font 18pt; launched from `~/` (not from inside any repo).

## Execute in this order

### Step 0 — Inventory first

Before changing anything, list what already exists. Many of these may already be set up on a long-lived machine.

```bash
ls ~/repos/                                            # bucket directories present?
ls ~/.azure/ 2>/dev/null                               # SAS env files already?
ls ~/.claude/projects/ 2>/dev/null                     # memory dir present?
test -L ~/.claude/CLAUDE.md && readlink ~/.claude/CLAUDE.md   # global CLAUDE.md symlink?
which uv && which git && which python3                 # tooling?
echo $PATH | tr ':' '\n' | grep -i local               # is ~/.local/bin on PATH?
```

Only fill the gaps; do not overwrite working state.

### Step 1 — Memory transfer

The source machine produces `memory_bootstrap.tar.gz` in a transient transfer location (e.g., `~/Queens College Dropbox/Dax Soule/_transfer/`). On the target:

```bash
TARGET_PROJECT="-Users-$(basename $HOME)"   # e.g., -Users-daxsoule on the desktop
mkdir -p ~/.claude/projects/$TARGET_PROJECT
cd ~/.claude/projects/$TARGET_PROJECT
tar xzf "<path-to-memory_bootstrap.tar.gz>"
```

Then translate any hardcoded source paths to the target's `$HOME`. Example for laptop → desktop:

```bash
cd ~/.claude/projects/$TARGET_PROJECT/memory
find . -name '*.md' -exec sed -i '' 's|/Users/dax/|/Users/daxsoule/|g' {} +
grep -r "/Users/dax/" . | head   # should print nothing
```

### Step 2 — claude-config and global CLAUDE.md

```bash
mkdir -p ~/repos && cd ~/repos
if [ ! -d claude-config ]; then
  git clone git@github.com:qc-soule-lab/claude-config.git
else
  cd claude-config && git pull --ff-only && cd ..
fi
ln -sfn ~/repos/claude-config/CLAUDE.md ~/.claude/CLAUDE.md
readlink ~/.claude/CLAUDE.md   # confirm it points at the claude-config copy
```

### Step 3 — Bucket directories

```bash
mkdir -p ~/repos/{class_dev,forms_dev,loc_science_dev,meeting_dev,report_dev}
```

### Step 4 — Clone the repos into their buckets

Skip any clone that already exists; `git pull --ff-only` instead.

```bash
cd ~/repos/class_dev
for r in geol-333-fall-2026 geol-393-fall-2026 geol-795-makayla-fall-2026 ocean540_guest_lecture; do
  [ -d "$r" ] || git clone "git@github.com:daxsoule/$r.git"
done

cd ~/repos/forms_dev
[ -d qc_forms ] || git clone git@github.com:daxsoule/qc_forms.git

cd ~/repos/loc_science_dev
[ -d ctdMAB_my-analysis ] || git clone git@github.com:daxsoule/ctdMAB_my-analysis.git
[ -d joseph-scaleworm-thesis ] || git clone git@github.com:qc-soule-lab/joseph-scaleworm-thesis.git
# bravoseis_orca_3d: Hub-primary (the actual science work runs on JupyterHub
# at /home/jovyan/repos/loc_science_dev/bravoseis_orca_3d). Do NOT clone on a
# Mac unless you have a specific local use case; the Mac is not where this
# project's analysis runs.

cd ~/repos/report_dev
[ -d expense_reports ] || git clone git@github.com:daxsoule/expense_reports.git
[ -d sabbatical_reports ] || git clone git@github.com:daxsoule/sabbatical_reports.git
```

`meeting_dev/OOIFB_May2026_Plan` has no GitHub remote at the time of writing; the user decides whether to push or treat it as machine-local.

For each cloned repo, `.venv/` is NOT in git. Recreate per repo with `uv venv` and `uv pip install -r requirements.txt` (or `uv sync` if it has a `pyproject.toml`) as needed.

### Step 5 — Azure data lake

The source machine produces `azure_bootstrap.tar.gz` containing only the SAS env files (no master account key, no sync-daemon state). On the target:

```bash
cd ~
tar xzf "<path-to-azure_bootstrap.tar.gz>"
chmod 700 ~/.azure
chmod 600 ~/.azure/*.env
chmod 600 ~/.azure/handoff/*.env 2>/dev/null
```

Symlink `azure_lake` into PATH:

```bash
mkdir -p ~/.local/bin
ln -sfn ~/repos/claude-config/tools/azure_lake ~/.local/bin/azure_lake
# Ensure ~/.local/bin is on PATH (add to ~/.zshrc if missing):
grep -q 'HOME/.local/bin' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
```

Verify:

```bash
source ~/.azure/bravoseis.env && azure_lake info
```

Expected: `account: soulesciencedata`, `container: bravoseis`, `permissions: read, add, create, write, delete, list`, `expiry (UTC): 2026-08-31...`.

**Rotation reminder:** the lab's SAS tokens now exist on Hub, Windows PC, laptop, and desktop. When the SAS regen runs (next around 2026-08-10 per the cron routine), fresh tokens must reach all four locations. The cron routine prompt at `claude.ai/code/routines` should be updated to list all four.

### Step 6 — JupyterLab

The lab convention: JupyterLab is installed inside `class_dev/ocean540_guest_lecture/.venv/`. If the target already has JupyterLab elsewhere and it works, leave it alone. If setting up fresh:

```bash
cd ~/repos/class_dev/ocean540_guest_lecture
uv venv --python 3.14
uv pip install jupyterlab
```

Launch from `~/` so the file tree opens at home (not inside any repo):

```bash
cd ~ && ~/repos/class_dev/ocean540_guest_lecture/.venv/bin/jupyter-lab --no-browser
```

User-settings convention: terminal font 18pt. Set in JupyterLab Settings → Advanced Settings Editor → Terminal:

```json
{ "fontSize": 18 }
```

### Step 7 — Verify

```bash
readlink ~/.claude/CLAUDE.md                              # claude-config/CLAUDE.md
ls ~/.claude/projects/-Users-$(basename $HOME)/memory/    # 14+ .md files including MEMORY.md
ls ~/repos/                                               # 5 buckets + claude-config + dotfiles
source ~/.azure/bravoseis.env && azure_lake info          # metadata block
for d in ~/repos/*/*/; do (cd "$d" && echo "  $d → $(git status -sb 2>/dev/null | head -1)"); done
```

Read `~/.claude/projects/-Users-$(basename $HOME)/memory/MEMORY.md` and walk the index — every entry should be live, and no entry should reference a path the target machine doesn't have.

When all 7 steps pass, the target mirrors the source. Report any gaps or unexpected state to the user before assuming the mirror is complete.
