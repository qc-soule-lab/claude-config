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
