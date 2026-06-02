<!-- qc-soule-lab — PORTABLE / off-Hub baseline rules.
     For machines that are NOT the OOI JupyterHub (personal laptop, a Windows PC, etc.).
     Deploy: copy this file to ~/.claude/CLAUDE.md (Windows: %USERPROFILE%\.claude\CLAUDE.md).
     Source of truth: qc-soule-lab/claude-config (CLAUDE.portable.example.md).

     Difference from the full Hub CLAUDE.md: the universal rules are identical, but two
     environment-specific sections are intentionally omitted — "Parallel Worker Cap"
     (JupyterHub 32-core containers) and "Repos Layout" (the PI's Mac bucket layout) —
     and the two automatic-hook references are softened, because the lab hooks rely on
     /home/jovyan absolute paths and do NOT run off the Hub. Off-Hub, the guardrails are
     advisory: you must self-invoke /ethical-check rather than rely on a hook prompt. -->

# Claude Code Instructions (portable / off-Hub)

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

**Image display in notebooks**: Always use **`imshow`** (matplotlib) for displaying images — not `IPython.display.Image` or PIL `.show()`.

**General rule**: Match the tool to the audience. If someone will interact with the plot (explore data, hover for values, rotate 3D), use Plotly. If it goes in a paper or PDF, use matplotlib.

## Naming Conventions

**All new directories and files use `snake_case` lowercase.** Examples: `lesson_plans/`, `week_03_least_squares/`, `data_loader.py`, `provenance_notes.md`, `figure_01_overview.png`. This matches PEP 8 for Python and stays consistent across the data/science stack.

**Exceptions — preserve as-is, don't rename**:

- **External-convention names**: filenames or dirs whose form is dictated by an ecosystem or tool — `README.md`, `LICENSE`, `CHANGELOG.md`, `Makefile`, `Dockerfile`, `.github/`, `node_modules/`, `pyproject.toml`, `CLAUDE.md`, `MEMORY.md`, etc.
- **Archive directories**: anything under `archive/` (or similar historical-reference folder) keeps its original filename — archives exist to preserve provenance.
- **Pre-existing files**: don't rename files that already exist unless the user explicitly asks. The rule applies forward to *new* files and dirs you create.

Reason: predictable, scannable layouts; case-insensitive filesystems (macOS APFS, Windows NTFS) hide bugs that git's case-sensitive tracking later surfaces — a single lowercase convention eliminates the whole class.

## Testing

**All code must pass pytest before being committed.** Pushing code that fails tests is unacceptable.

- Run `uv run pytest` (or `pytest` if not in a uv project) before every commit.
- If tests fail, fix the code — do not skip, disable, or delete failing tests to make a commit pass.
- When writing a new script or module, write tests for any non-trivial logic (utilities, data transformations, calculations). Test files go in `tests/` at the project root.
- `pytest` should be in every project's dev dependencies. Add with `uv add --dev pytest` if missing.

## Memory Management

**Crash resilience is the priority.** Assume the session can die at any moment — if a new session started right now, would memory accurately describe what's done and what's next? Update proactively, not at the end: on blockers, status changes, "I'm leaving" signals, and milestones. (Off-Hub there is no commit-hook reminder, so be disciplined about updating without a prompt.) Keep MEMORY.md indexes in sync; delete stale memories rather than letting them accumulate.

## Ethical Check Standard

**Prevent early, not remediate late.** Invoke the **`ethical-check`** skill before introducing new literature/data, producing prose for human reading, regenerating a figure that resembles a published one, committing/pushing/sharing outputs externally, WebFetching external sources, or when tempted to fudge a result (outlier drops, post-hoc thresholds, memory-based paraphrasing). The skill covers the 7-point check (provenance, license/TOS, PII, embargo, attribution, reproducibility, blast radius) and the publisher-PDF / AI-disclosure / literature-handling hard rules. (Off-Hub the automatic `PreToolUse(WebFetch)` hook is NOT present, so you must **self-invoke `/ethical-check`** at these moments rather than relying on a hook prompt — and the skill itself must be installed at `~/.claude/skills/` for `/ethical-check` to be available.)
