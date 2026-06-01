# Orientation — {{NAME}} (collaborator)

**Goal:** bring {{NAME}}'s environment to the lab standard and get them working in their project repo.

- Project repo: **{{PROJECT_REPO}}**
- Azure container (their own space): **{{CONTAINER}}**
- GitHub org: **{{ORG}}** · Seat: **Premium** (Opus available)

Work through these with them (they're an experienced peer — move efficiently, but confirm each external-effect step):

### 1. Confirm authentication
They launched `claude`, so their `{{ORG}}` Team (Premium) seat works. If they hit an auth error, they need to sign in under the lab account first.

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
Dax sent a credential file. Save it as `~/.azure/{{CONTAINER}}.env` (chmod 600), then:
```bash
chmod 600 ~/.azure/{{CONTAINER}}.env && source ~/.azure/{{CONTAINER}}.env
azure_lake info       # shows their container + SAS expiry
```
**Never print the SAS URL.** If it appears, tell Dax to rotate it.

### 5. Verify SpecKit
```bash
science-specify check
```
(`science-specify init` only if a repo needs scaffolding — ask first.)

### 6. Conventions
Open the project repo's `CLAUDE.md` (the collaborator version) and confirm the essentials: run `ethical-check` before new data/prose/sharing; never commit secrets or third-party raw data; branch + PR (tag Dax on shared-result changes); `uv run pytest` before commits; derived data → Azure via `azure_lake`; ≤24 workers on the shared host; Opus available on their Premium seat.

**End state:** bootstrapped env, project repo cloned, `azure_lake info` works, `science-specify check` passes, conventions understood. Then they work in the **project repo**, not this onboarding repo.
