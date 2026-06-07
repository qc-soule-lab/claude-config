# Claude Code Instructions

## Parallel Worker Cap

**Never start a job that employs more than 24 workers without explicit instructions from the user.** This applies to multiprocessing pools, `--workers` / `-j` / `-n` flags, GNU parallel, xargs -P, joblib, dask, or any other form of parallel execution. If a script's default worker count exceeds 24, override it down to 24 or ask first.

Reason: JupyterHub containers on this host are CPU-capped (commonly 32 cores). Launching 175 workers once triggered a container restart mid-pipeline and lost ~60 min of location work (2026-04-05 incident). 24 workers stays comfortably under the cap with headroom for the parent process and kernel overhead.

If the user wants to exceed 24, they will say so explicitly ("use 48 workers", "run with --workers 64"). Otherwise, 24 is the ceiling.

**Concurrent agents share the 24 cap.** When launching N concurrent background agents, each agent's personal worker cap is `floor(24 / N)`, not 24. Compute this number before dispatch and include it explicitly in each agent's prompt ("use AT MOST X parallel workers — the system-wide 24 is shared across N concurrent agents"). Near-miss incident 2026-04-12: six agents × 24 workers each = 144+ workers, which would have hit the same failure mode. Default bias toward fewer concurrent agents (2–3 for compute-heavy work).

## AI-Generated Text Disclosure

**All AI-generated explanatory text must be clearly labeled.** When Claude produces prose — methods descriptions, notebook markdown cells, README sections, figure captions (Temp or final), or any narrative text intended for human reading — it must include a disclosure label.

**Format**: Two elements are required:

1. **Disclosure label** — Italicized line at the top of the text block:
   ```markdown
   *AI-generated draft (Claude, Anthropic) — for review. All parameters and figures are derived from version-controlled scripts and data.*
   ```

2. **Machine font** — AI-generated prose uses **Courier New / monospace** to visually distinguish it from human-authored content:
   - In rendered documents (PDF/HTML): set `font-family: "Courier New", "Courier", monospace` for the body text
   - In Jupyter notebook markdown cells: wrap AI text in `<span style="font-family: 'Courier New', monospace;">...</span>` or use code-fence styling
   - In plain markdown (`.md` files): the italic disclosure label is sufficient (monospace rendering depends on viewer)

**Rules**:
- The disclosure must be the **first line** of the document or markdown cell containing AI-generated prose.
- The monospace font is the primary visual signal — a reader should be able to identify AI-generated text at a glance by its typeface.
- This applies to: methods documents, notebook markdown cells with explanatory text, README content, report drafts, and any other prose output.
- This does **not** apply to: code, code comments, commit messages, file names, or short inline labels (e.g., axis titles, legend entries).
- If the user edits the text substantially, they may remove or modify the disclosure at their discretion.

## Package Preferences for Outputs

**Data visualization**:
- **Exploratory / student-facing work**: Use **Plotly** (interactive, hover, zoom)
- **Publication / paper figures**: Use **matplotlib** (static, fine control, 300+ DPI PNG)

**Image display in JupyterLab**: Always use **`imshow`** (matplotlib) for displaying images in notebooks — not `IPython.display.Image` or PIL `.show()`.

**General rule**: Match the tool to the audience. If someone will interact with the plot (explore data, hover for values, rotate 3D), use Plotly. If it goes in a paper or PDF, use matplotlib.

## Naming Conventions

**All new directories and files use `snake_case` lowercase.** Examples: `lesson_plans/`, `week_03_least_squares/`, `data_loader.py`, `provenance_notes.md`, `figure_01_overview.png`. This matches PEP 8 for Python and stays consistent across the data/science stack.

**Exceptions — preserve as-is, don't rename**:

- **External-convention names**: filenames or dirs whose form is dictated by an ecosystem or tool — `README.md`, `LICENSE`, `CHANGELOG.md`, `Makefile`, `Dockerfile`, `.github/`, `node_modules/`, `pyproject.toml`, `CLAUDE.md`, `MEMORY.md`, etc.
- **Archive directories**: anything under `archive/` (or similar historical-reference folder) keeps its original filename — archives exist to preserve provenance.
- **Pre-existing files**: don't rename files that already exist unless the user explicitly asks. The rule applies forward to *new* files and dirs you create.

Reason: predictable, scannable layouts; case-insensitive filesystems on macOS (APFS default) hide bugs that git's case-sensitive tracking later surfaces — a single lowercase convention eliminates the whole class.

## Pythonic Conventions

**Write idiomatic, PEP 8-compliant Python.** New code should read cleanly and follow standard idioms.

- **Format + lint with `ruff`** — run `ruff format` and `ruff check` before committing (alongside `uv run pytest`). `ruff` is in the lab dev dependencies and configured in `pyproject.toml` (it replaces black/flake8/isort); don't hand-format around it.
- **Type hints** on the signatures of shared or non-trivial functions (utilities, data transforms, calculations) — not required on quick notebooks or throwaway scripts.
- **Docstrings** — a one-line summary (plus args/returns for non-obvious utilities) on modules and functions whose behavior isn't self-evident.
- **Idioms** — prefer `pathlib` over `os.path`, f-strings over `%`/`str.format`, comprehensions and context managers (`with`) over manual loops/cleanup, and the standard library before adding a dependency.
- **Layout** — packages use a `src/` layout with `pyproject.toml`; keep modules small and focused.
- **Ethos (PEP 20)** — explicit over implicit, simple over complex, flat over nested, readability counts; apply it when writing and in `/code-review`.

Applies to **new** code; don't churn/reformat existing files just to satisfy the linter unless you're already editing them (or asked to).

## Machine Landscape & Naming

Work spans five machines. Refer to each by its **canonical tag** below, never by ambiguous terms like "the laptop" or "the Mac" — there are two laptops and three Macs, and loose terms have already caused memory to conflate them.

| Tag | Machine | `$HOME` |
|---|---|---|
| **Hub** | OOI JupyterHub (Linux container) | `/home/jovyan` |
| **iMac** | office desktop | `/Users/daxsoule` |
| **MacBook** | laptop (authored most current memory notes) | `/Users/dax` |
| **MacBookPro** | laptop | `/Users/dax` *(home name TBD — confirm on first use)* |
| **DellPC** | Windows; Oasis Montaj / Geosoft host | `C:\Users\neand` |

Rules:

- **Paths under `$HOME` use `~`, not an absolute home dir.** The structure under `~` — especially `~/repos/<bucket>/...` — is identical on all three Macs, so `~/repos/forms_dev/qc_forms` is correct everywhere while `/Users/dax/...` or `/Users/daxsoule/...` is machine-specific and breaks when a note is read on another machine. Same for Dropbox: `~/Queens College Dropbox/...`.
- **Tag any machine-specific fact** with its bracketed tag, e.g. `[iMac]`, `[DellPC]`. A fact true on only one machine must say which one. Hub paths (`/home/jovyan/...`) and DellPC paths (`C:\Users\neand\...`) are genuinely absolute — keep them, but tag them.
- **bravoseis_orca_3d is [Hub]-only.** Do not clone it or pull its Azure payload onto the Macs.

## Repos Layout

Projects under `~/repos/` (identical bucket layout on iMac, MacBook, MacBookPro) are organized into buckets (adopted 2026-05-30):

- `class_dev/` covers course development. Currently holds `geol-333-fall-2026`, `geol-393-fall-2026`, `geol-795-makayla-fall-2026`, `ocean540_guest_lecture`.
- `forms_dev/` covers university forms and paperwork. Currently holds `qc_forms`.
- `loc_science_dev/` covers science work that runs on a local machine (as opposed to OOI or other cloud servers). Currently holds `ctdMAB_my-analysis`, `joseph-scaleworm-thesis`.
- `meeting_dev/` covers meeting prep, talks, and briefings. Currently holds `OOIFB_May2026_Plan`.
- `report_dev/` covers formal reports and written deliverables (expense, NSF project, multi-position, sabbatical, annual eval). Holds scripts only; final reports and receipts live in Dropbox, not git. Currently holds `expense_reports`, `sabbatical_reports`.

Two infra dirs stay at the `repos/` root: `claude-config` (Claude settings; this file lives there) and `dotfiles` (shell + editor configs).

When creating a new repo, place it under the bucket that matches its purpose. Bucket directory names follow the snake_case rule above.

## Testing

**All code must pass pytest before being committed.** Pushing code that fails tests is unacceptable.

- Run `uv run pytest` (or `pytest` if not in a uv project) before every commit.
- If tests fail, fix the code — do not skip, disable, or delete failing tests to make a commit pass.
- When writing a new script or module, write tests for any non-trivial logic (utilities, data transformations, calculations). Test files go in `tests/` at the project root.
- `pytest` should be in every project's dev dependencies. Add with `uv add --dev pytest` if missing.

## Memory Management

**Crash resilience is the priority.** Assume the session can die at any moment — if a new session started right now, would memory accurately describe what's done and what's next? Update proactively, not at the end. A `PostToolUse(Bash(git commit:*))` hook injects a reminder after every commit; also update on blockers, status changes, "I'm leaving" signals, and milestones. Keep MEMORY.md indexes in sync; delete stale memories rather than letting them accumulate.

## Ethical Check Standard

**Prevent early, not remediate late.** Invoke the **`ethical-check`** skill before introducing new literature/data, producing prose for human reading, regenerating a figure that resembles a published one, committing/pushing/sharing outputs externally, WebFetching external sources, or when tempted to fudge a result (outlier drops, post-hoc thresholds, memory-based paraphrasing). Skill covers the 7-point check (provenance, license/TOS, PII, embargo, attribution, reproducibility, blast radius) and the publisher PDF / AI-disclosure / literature-handling hard rules. A `PreToolUse(WebFetch)` hook surfaces the same reminder whenever a URL matches a publisher or DOI-resolver domain.
