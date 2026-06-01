# Orientation — {{NAME}}

**Goal:** bring {{NAME}}'s environment up to the lab standard and get them working in their project repo.

- Project repo: **{{PROJECT_REPO}}**
- Azure container (their own space): **{{CONTAINER}}**
- GitHub org: **{{ORG}}**

Guide the member through these steps **one at a time**, confirming each before the next.

### 1. Confirm they're authenticated
They launched `claude`, so their `{{ORG}}` Team seat is working. If they hit an auth error instead, stop — they need to sign in to Claude Code under their lab (Team) account first.

### 2. Clone the project repo and enter it
```bash
cd ~ && git clone {{PROJECT_REPO}}
cd "$(basename {{PROJECT_REPO}} .git)"
```

### 3. Run the lab bootstrap (from inside the project repo)
This installs uv, the lab Claude config (skills incl. `ethical-check`, hooks, the global rules), SpecKit, the project's Python deps (`uv sync`), a Jupyter kernel, and the `azure_lake` CLI:
```bash
git clone {{CLAUDE_CONFIG_URL}} ~/repos/claude-config 2>/dev/null || true
bash ~/repos/claude-config/bootstrap-student.sh
```
Explain what it's doing as it runs; it may take a few minutes on first sync.

### 4. Set up Azure access
Dr. Soule sent them a credential file. Have them save it as `~/.azure/{{CONTAINER}}.env` and lock it down:
```bash
mkdir -p ~/.azure && chmod 700 ~/.azure
# paste/move the file to ~/.azure/{{CONTAINER}}.env, then:
chmod 600 ~/.azure/{{CONTAINER}}.env
source ~/.azure/{{CONTAINER}}.env
azure_lake info     # should show their container + SAS expiry
```
**Never print the SAS URL.** If it appears on screen, tell them to notify Dr. Soule so it can be rotated.

### 5. Verify SpecKit
```bash
science-specify check
```
If the project repo isn't SpecKit-scaffolded and should be, run `science-specify init` (ask first).

### 6. Walk them through the rules
Open the project repo's `CLAUDE.md` and summarize the non-negotiables in plain language:
- Run the **`ethical-check`** skill before new data/literature, prose for humans, or committing/sharing.
- **Never commit** secrets (SAS URLs, keys) or raw data the lab doesn't own.
- **Branch + PR** — never push to `main`; `uv run pytest` before every commit.
- Big/derived data → **Azure via `azure_lake`** (not git); small tables/figures/scripts → git.
- Shared host: keep parallel jobs **≤24 workers**.

### 7. First branch → PR (prove the workflow)
Help them create a throwaway branch, make a trivial change, commit (pytest first), push, and open a PR — so they've done one full cycle before real work.

**End state:** bootstrapped env, project repo cloned, `azure_lake info` works, `science-specify check` passes, they understand the rules, and they've completed one branch→PR. Then they work in the **project repo**, not this onboarding repo.
