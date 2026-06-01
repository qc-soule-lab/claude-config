<!-- qc-soule-lab shared student-project baseline. Source of truth: claude-config repo.
     Deploy: copy this file to the root of EACH student's project repo as CLAUDE.md.
     Repo-agnostic — not tied to any single student's project. -->

# qc-soule-lab — Student Project Instructions

These instructions are binding for work in this repository. They exist to keep lab work **ethical, reproducible, and safe to share**. When in doubt, **ask Dr. Soule before acting** — never guess on data exclusion, thresholds, sharing, or anything touching data you didn't generate.

> Setup note: the **`ethical-check` skill** and lab standards referenced below live in your `~/.claude` config (deployed by the lab). If `/ethical-check` isn't available, tell Dr. Soule — your environment isn't fully set up yet.

## 1. Ethical boundaries (non-negotiable)

Run the **`ethical-check`** skill BEFORE you: introduce a new dataset or paper, produce prose meant for human reading, regenerate a figure that resembles a published one, **commit/push/share anything**, fetch from the web, or feel tempted to "clean up" a result.

- **Literature:** Only read PDFs that are in `literature/open_access/` or that you have a clear right to use. **NEVER** feed paywalled/publisher PDFs or anything under `literature/embargoed/` to Claude, and **don't WebFetch publisher or DOI-resolver domains.** If you need a paper, ask Dr. Soule to place it.
- **AI-generated prose must be disclosed.** Any AI-written methods text, README content, notebook markdown, captions, or report prose carries the lab disclosure label (italic line at top) and monospace styling. This does **not** apply to code, code comments, commit messages, or short axis/legend labels.
- **No borrowed assumptions.** Re-evaluate every filter/threshold per dataset; document provenance for every input (where it came from, when, under what authority).
- **No fudging.** Do not drop outliers, tune thresholds post-hoc, or tweak a figure to match a hypothesis **without a documented rule approved by Dr. Soule.** If you notice the temptation, surface it.
- **Attribution.** Cite every data source and acknowledge contributed data in figure captions and methods.

## 2. Never commit or upload

- **Raw data the lab doesn't own** (third-party / contributed datasets) — these stay where they are.
- **Credentials** — SAS URLs, API keys, tokens. A SAS URL is a bearer credential; if one ever appears in output or a file, treat it as leaked and tell Dr. Soule.
- **PII** (none expected in this domain, but the rule stands).
- **Publisher PDFs** and **large binaries** (PowerPoint decks, raw video, multi-GB files).

## 3. Git workflow → `qc-soule-lab` (GitHub org)

This repo lives under the **`qc-soule-lab`** organization. Work through pull requests:

1. **Never commit directly to `main`.** Create a branch: `git checkout -b <yourname>/<short-topic>`.
2. **Run `uv run pytest` before every commit.** Do not commit failing tests; do not disable/skip tests to make a commit pass. Write tests for non-trivial logic (`tests/`).
3. Commit with clear, descriptive messages. **Double-check the diff for secrets/data before committing** (see §2).
4. Push your branch and **open a PR**; Dr. Soule (or a maintainer) reviews before merge to `main`.
5. `git pull` `main` regularly to stay current.

## 4. Data handling → Azure (not git)

Derived/large/regenerable outputs go to **Azure Blob Storage**, NOT git. The split:

- **→ git:** scripts, notebooks, specs, **small** summary tables (KB–few MB CSV), paper-tier figures, methods narratives.
- **→ Azure:** large derived parquets, model caches, big figures (>10 MB), anything regenerable that takes >5 min to recompute.
- **→ neither (never leave the machine):** raw third-party data, credentials, PII.

Use the lab CLI with **your own scoped credentials** (Dr. Soule will provision these — see the setup note he gives you):

```bash
source ~/.azure/<your-container>.env          # loads YOUR scoped SAS into $AZURE_BLOB_SAS_URL
azure_lake upload outputs/data/<file>.parquet --blob-name <prefix>/<file>.parquet --overwrite
azure_lake ls                                  # list what's there
```

- **Never print, paste, or commit the SAS URL.** Load it from your `~/.azure/*.env` only.
- Your credential is **scoped to your own container** (`<project>-<yourname>`) and **revocable** — don't share it or use anyone else's.
- **Use `azure_lake` for uploads** (manual, simple). The `azure_sync` background daemon is the PI's setup — you don't need to run it.
- Your SAS **expires (~90 days)** — when uploads start failing with an auth error, ask Dr. Soule to regenerate it. Don't work around it.

## 5. Compute etiquette (shared host)

The JupyterHub host is **CPU-capped and shared across the lab.**

- **Do not start a job using more than 24 parallel workers** (multiprocessing pools, `-j`/`--workers`/`n_jobs`, joblib, GNU parallel, etc.) without checking with Dr. Soule — 24 is the lab ceiling. If a tool's default would exceed it, override it down.
- Be considerate: it's a shared host, so don't kick off a big parallel job when others are clearly running heavy work.

## 6. Conventions

- **Packages:** `uv add` only — never `pip install`.
- **Model:** Sonnet is your default — it's well-suited to implementing/modifying lab code, keeping parameters straight, and git hygiene. Use `/model` to switch up only if you hit a genuinely hard problem.
- **Outputs:** processed data → `outputs/data/` (Parquet); figures → `outputs/figures/` (300 DPI); tables → `outputs/tables/`. Raw data is immutable.
- **Figures:** Plotly for exploratory/interactive work; **matplotlib** for publication figures (300 DPI PNG). Display images with `imshow`, not PIL/IPython.
- **When blocked or unsure:** ask Dr. Soule. This is research — getting it right matters more than getting it fast.
