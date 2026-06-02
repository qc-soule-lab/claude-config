# Orientation — {{NAME}} (collaborator)

**Goal:** bring {{NAME}}'s environment to the lab standard and get them working in their project repo.

- Project repo: **{{PROJECT_REPO}}**
- Azure container (their own space): **{{CONTAINER}}**
- GitHub org: **{{ORG}}** · Seat: **Premium** (Opus available)

Work through these with them (they're an experienced peer — move efficiently, but confirm each external-effect step):

### 1. Confirm authentication
They launched `claude` — have them run `/status` to confirm the `{{ORG}}` Team (Premium) seat. If the login won't complete (the Hub's localhost browser callback often can't connect), use a token: `claude setup-token` → approve in browser → `export CLAUDE_CODE_OAUTH_TOKEN=<token>` → relaunch. If `/status` shows no seat, their Team invite isn't active yet — check with Dax.

### 2. Clone the project repo
```bash
cd ~ && git clone {{PROJECT_REPO}}
cd "$(basename {{PROJECT_REPO}} .git)"
```

### 3. Run the lab bootstrap (collaborator role)
Installs uv, the lab Claude config (skills incl. `ethical-check`, hooks), SpecKit, project deps (`uv sync`), a Jupyter kernel, and `azure_lake`. The `--role collaborator` flag seeds the collaborator settings (Opus available, not Sonnet-locked):
```bash
git clone {{CLAUDE_CONFIG_URL}} ~/repos/claude-config 2>/dev/null || true
bash ~/repos/claude-config/bootstrap-student.sh --role collaborator
```

### 4. Azure access
Dax securely sends the SAS for **their own** container `{{CONTAINER}}`. Save it robustly (these traps bite even experienced users): the dir must exist first, the JupyterLab "Save As" can't write hidden dotfolders, and a pasted `read`/`&&` one-liner breaks on a stray newline. Use `nano`:
```bash
mkdir -p ~/.azure && chmod 700 ~/.azure       # bootstrap also does this
nano ~/.azure/{{CONTAINER}}.env
#   one line:  export AZURE_BLOB_SAS_URL='<paste SAS URL between the quotes>'
#   paste = Ctrl+Shift+V / right-click / Cmd+V ; save = Ctrl-O, Enter ; exit = Ctrl-X
chmod 600 ~/.azure/{{CONTAINER}}.env
source ~/.azure/{{CONTAINER}}.env && azure_lake info && azure_lake ls && echo OK
```
`azure_lake info` shows container `{{CONTAINER}}` + `racwdl` + expiry; `ls` empty + `OK` = reaches Azure. **Never let the SAS land in chat, a commit, or shared output** (in their own nano/terminal is fine); if it does, tell Dax to rotate it.

### 5. Verify SpecKit
```bash
science-specify check
```
(`science-specify init` only if a repo needs scaffolding — ask first.)

### 6. Conventions
Open the project repo's `CLAUDE.md` (the collaborator version) and confirm the essentials: run `ethical-check` before new data/prose/sharing; never commit secrets or third-party raw data; branch + PR (tag Dax on shared-result changes); `uv run pytest` before commits; derived data → Azure via `azure_lake`; ≤24 workers on the shared host; Opus available on their Premium seat.

**End state:** bootstrapped env, project repo cloned, `azure_lake info` works, `science-specify check` passes, conventions understood. Then they work in the **project repo**, not this onboarding repo.
