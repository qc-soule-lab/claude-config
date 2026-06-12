# {{PROJECT_NAME}} — Claude Code Instructions

*Canonical analysis-project template (claude-config/templates/, v1 2026-06-12). Replaces the three divergent per-project variants — copy, fill the {{placeholders}}, delete this line.*

## Project Context
{{1–2 sentences: the scientific question, the dataset, the deliverable.}}

## Package Management
- `uv add` only — never `pip install`. (Legacy pip projects need an explicit PI exemption noted here.)

## Code Conventions
- Data outputs → `outputs/data/` · figures → `outputs/figures/` · docs → `outputs/docs/`.
- Global rules apply (snake_case, ruff, PEP 8, type hints on shared functions — see global CLAUDE.md).

## Scientific Standards
- **No Borrowed Assumptions**: every filter/threshold justified for THIS dataset; sibling-project conventions re-verified before reuse (see global CLAUDE.md → Scientific Quality Standards).
- **Defensible Statistics**: uncertainty with every claim; bootstrap conventions stated (n, seed, method).
- {{Project-specific QC rules — e.g. known sensor failure modes, de-tided-product traps.}}

## Figure Standards
- Run `/map-figure` or `/timeseries-figure` before committing any figure; record P/F/– in `specs/map-scorecard.md` / `specs/timeseries-scorecard.md` (the pre-commit gate enforces this for new figures).
- **Rubric tier: {{Paper | Presentation | Poster}}** (declared here, machine-readable; tier thresholds in shared standards).
- Colorblind-safe palettes per global CLAUDE.md (Okabe-Ito / viridis / cmocean).

## SpecKit Workflow
- Constitution at `.specify/memory/constitution.md`; **regenerate its PDF after every edit**: `uv run python scripts/make_doc_pdf.py .specify/memory/constitution.md` (canonical path; the pre-commit gate blocks constitution edits without a PDF).
- Constitution versioning: **MAJOR** bump for Core Principles / research-context / falsification changes; **MINOR** for additions and clarifications. Keep a Changelog section.
- SpecKit tier for this project: **{{full (specify→clarify→plan→tasks→analyze) | lite (constitution + spec only — sufficient for single-question analyses)}}**. Lite is a choice, not drift — record it here.
- Save clarify Q&A and post-analyze summaries to `.specify/memory/` as they happen.

## Data Locations
- {{Project data paths. Shared OOI/lab paths: see the canonical reference in the umbrella memory — don't restate, link.}}
- Sibling-project dependencies: {{list, or "none"}}. When loading another project's product, read its constitution QC section first and record its version here.

## Literature
- `literature/{open_access, library_subscription, author_copies, embargoed}/` + inventory README; targeted `.gitignore` (`literature/**/*.pdf`) — never a blanket `*.pdf` rule. `embargoed/` is never fed to Claude.

## Security
- No secrets in git (the pre-commit hook blocks SAS/keys); big/derived data → Azure via `azure_lake`, not git; ≤ 24 parallel workers (shared host).
