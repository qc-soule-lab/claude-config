# qc-soule-lab — onboarding for {{NAME}}

Welcome aboard. This repo gets your Claude Code + lab environment set up.

## Step 0 — one-time setup (do first)

Your OOI JupyterHub container may not have these yet:

- **GitHub auth** (needed even to clone — these repos are private): `gh auth login` (GitHub.com → HTTPS → web browser). If `gh` isn't installed, run `git config --global credential.helper store` and use a **Personal Access Token** (github.com → Developer settings → Tokens (classic), scope `repo`) as the git password.
- **Claude Code:** `claude --version`; if "command not found", `curl -fsSL https://claude.ai/install.sh | bash` then `export PATH="$HOME/.local/bin:$PATH"`.

## Three steps

1. **Clone:** `git clone https://github.com/{{ORG}}/onboard-{{SLUG}}.git && cd onboard-{{SLUG}}`
2. **Launch:** `claude` — if the browser login hangs (common on the Hub), use `claude setup-token` instead (approve in your browser, paste the token back), then `claude` again; `/status` should show your Team seat.
3. **Type:** `Onboard me — read ORIENTATION.md and walk me through it.`

Claude sets up your tools, your project repo, and Azure access, and points you at the lab conventions. **Have ready:** the Azure SAS Dax will send you securely. Anything off, ping Dax.
