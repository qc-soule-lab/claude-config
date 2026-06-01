<!-- qc-soule-lab shared COLLABORATOR-project baseline. Source of truth: claude-config repo.
     Deploy: copy to the root of a collaborator's working repo as CLAUDE.md.
     Peer-framed variant of CLAUDE.student-project.example.md. -->

# qc-soule-lab — Collaborator Project Instructions

These are the lab's working conventions for this repository. You're a collaborator/peer — use your judgment on the science; coordinate with Dax on **scope, shared-data decisions, and anything that leaves the machine**. The items in §1–2 are non-negotiable regardless of seniority.

> Setup note: the **`ethical-check` skill** and lab hooks referenced below come from the lab `~/.claude` config (installed by the bootstrap). If `/ethical-check` isn't available, your environment isn't fully set up.

## 1. Ethical boundaries (non-negotiable)

Run the **`ethical-check`** skill before introducing new data/literature, producing prose for human reading, regenerating a figure that resembles a published one, **committing/pushing/sharing**, fetching from the web, or when tempted to drop an outlier / tune a threshold post-hoc.

- **Literature:** only feed PDFs from `literature/open_access/` or that you have a clear right to use; **never** feed paywalled/publisher PDFs or anything under `literature/embargoed/`, and don't WebFetch publisher / DOI-resolver domains.
- **AI-generated prose must be disclosed** (italic label + monospace) — methods text, README, notebook markdown, captions, report drafts. Not code/comments/commit messages.
- **Provenance + attribution:** document where every input came from; cite sources; acknowledge contributed data in captions/methods.
- **No fudging:** outlier drops / threshold choices get a documented rule. Surface the temptation rather than quietly doing it.

## 2. Never commit or upload

Raw data the lab doesn't own (third-party / contributed); **credentials** (SAS URLs, API keys — a SAS is a bearer credential; if one leaks, tell Dax to rotate); PII; publisher PDFs; large binaries (decks, raw video, multi-GB files).

## 3. Git workflow → `qc-soule-lab`

You have write access to the repo(s) you've been added to. Work through pull requests:

1. **Branch, don't commit to `main`:** `git checkout -b <yourname>/<topic>`.
2. **`uv run pytest` before every commit** — don't commit failing tests or disable them to pass.
3. Review the diff for secrets/data before committing (§2); clear commit messages.
4. Open a **PR**; tag Dax (or the repo owner) for review on anything touching shared results.

## 4. Data handling → Azure (not git)

Large/derived/regenerable outputs → **Azure Blob Storage** via `azure_lake`, not git. Small summary tables / paper-tier figures / scripts / methods → git. Raw third-party data, credentials, PII → never leave the machine.

```bash
source ~/.azure/<your-container>.env     # loads YOUR scoped SAS
azure_lake upload outputs/data/<file>.parquet --blob-name <prefix>/<file>.parquet --overwrite
```
Your SAS is scoped to your own container and revocable; never print or commit it; it expires ~90 days (ask Dax to regenerate when uploads start failing). Use `azure_lake` manually — the `azure_sync` daemon is the PI's.

## 5. Compute etiquette (shared host)

The JupyterHub host is CPU-capped and shared. **Don't exceed 24 parallel workers** without checking with Dax; be considerate when others are running heavy jobs.

## 6. Conventions

- **Packages:** `uv add` only — never `pip install`.
- **Model:** your Premium seat has **Opus** available — use the model that fits the task (Opus for hard reasoning/design; Sonnet is fine for routine implementation). `/model` to switch.
- **Outputs:** data → `outputs/data/` (Parquet); figures → `outputs/figures/` (300 DPI); tables → `outputs/tables/`. Raw data immutable.
- **Figures:** Plotly for exploratory; **matplotlib** for publication (300 DPI). `imshow` for images.
