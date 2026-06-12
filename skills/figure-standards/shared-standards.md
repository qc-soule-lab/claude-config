# Shared Figure Standards

## Sizing Tiers

Each project constitution declares which tier applies. All font sizes are minimums.

| Tier | Use Case | Title | Axis/Caption | Tick/Feature Labels | Line Weight | Min DPI |
|------|----------|-------|--------------|---------------------|-------------|---------|
| **Poster** | Conference posters, large-format prints | >= 24pt | >= 18pt | >= 16pt (ticks) / >= 11pt (features) | >= 2pt | 600 |
| **Paper** | Journal figures, reports | >= 14pt | >= 10pt | >= 8pt | >= 1pt | 300 |
| **Presentation** | Slides, screen display | >= 20pt | >= 14pt | >= 12pt (ticks) / >= 10pt (features) | >= 1.5pt | 150 |

## Caption Technique: Full Justification

**Requirement (renderer-agnostic):** captions are fully justified in a dedicated region below the plot, last line left-aligned, with **no orphaned line** (an orphaned line = a single word alone on the final line; fix by adjusting caption width or text length). Font size per sizing tier.

**Font:** human-authored captions use sans-serif. **AI-generated caption text uses monospace (Courier New) and starts with the prefix `"AI-generated caption (Claude, Anthropic) — "`** per global CLAUDE.md → AI-Generated Text Disclosure — the disclosure rule overrides the sans-serif default.

**Matplotlib implementation** (other renderers: use native justification + manual orphan check):
1. Wrap text to fit available width using approximate character widths.
2. For each line except the last, measure each word's pixel width via `get_window_extent(renderer)`.
3. Distribute remaining horizontal space as equal gaps between words.
4. Left-align the last line.

## Colorblind Safety

All color distinctions must be perceivable under deuteranopia/protanopia. Named acceptable palettes: **Okabe-Ito** (discrete), **viridis/cividis** (continuous), **cmocean** (oceanographic), **IBM Carbon** or **Paul Tol** schemes as equivalents. "Equivalent" means a published colorblind-tested palette — not an eyeballed custom one.

## Data Provenance

Every figure caption or legend must identify:
- The instrument and data source for every plotted series
- Deployment period or collection year
- For derived data from sibling projects, cite the project and output file

## Resolution/Format

PNG at minimum DPI for the declared sizing tier. PDF available for vector when required by journal.

## Multi-Panel Labels

When a figure has multiple panels, label them consistently (e.g., "(a)", "(b)") at a standard position and font size.

## Scorecard Tracking

Each project maintains scorecards at `specs/timeseries-scorecard.md` and `specs/map-scorecard.md` using templates from the rubrics. **P** = Pass, **F** = Fail, **-** = Not applicable.
