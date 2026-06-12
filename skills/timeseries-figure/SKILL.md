---
name: timeseries-figure
description: Use when creating or evaluating time series plots. Provides 19 evaluation criteria for axis labels, legends, captions, data gaps, temporal aggregation, and layout standards.
---

# Time Series Figure Rubric

*Rubric v1.1 (2026-06-12) — anchored acceptance thresholds. Canonical copy: `claude-config/skills/timeseries-figure/SKILL.md`; project copies (e.g. `scaleworm-student-lab/specs/rubrics/`) point here.*

When creating or reviewing a time series figure, apply ALL of the following criteria. Also follow the shared standards in `~/.claude/skills/figure-standards/shared-standards.md` (sizing tiers, caption technique, colorblind palette, provenance, multi-panel labels). **Score each criterion against its anchor — the anchor decides, not overall impression.**

## Criteria

| # | Element | Required | Acceptance Standard (anchor) |
|---|---------|----------|---------------------|
| 1 | **Axis Labels** | Yes | Both axes labeled with quantity and unit in parentheses (e.g., "Temperature (°C)"). Bold. Font ≥ sizing-tier minimum. |
| 2 | **Dual-Axis Clarity** | If applicable | Secondary y-axis labeled and color-matched to its data series. Units stated. |
| 3 | **Date Formatting** | Yes | Tick labels at regular calendar intervals; **zero touching/overlapping labels**; rotation ≤ 45°. If labels would touch, reduce tick count rather than font size. |
| 4 | **Classification Legend** | Yes | Every plotted series identified by color, style, and descriptive label. Legend frame alpha ≥ 0.8 so it reads over gridlines. |
| 5 | **Event Annotation** | If applicable | Key events marked with vertical line + text label. Consistent visual language across the project's figures (e.g., red dashed = eruption, gray dotted = cruise/servicing) — record the convention in the project constitution (or this figure's caption until one exists). Bold annotation text. |
| 6 | **Title** | Yes | Concise 1–2 line title identifying the phenomenon, time period, and location. Font ≥ sizing-tier minimum. |
| 7 | **Figure Caption** | Yes | Fully justified (see shared standards). States axis quantities, identifies all data series by name and source, summarizes the key scientific observation. |
| 8a | **Aggregation stated** | Yes | The aggregation level (raw / hourly / daily means …) is named in the caption or axis label. Unstated aggregation = FAIL. |
| 8b | **Window trimmed + documented** | Yes | Data trimmed to the scientifically meaningful window (recovery artifacts, pre-deployment noise excluded) and the trim is named in the caption. |
| 8c | **Aggregation defensible** | Yes (judgment) | The level suits the signal: sub-daily signals (tides, events) need hourly-or-finer; multi-month trends tolerate daily means. **Never aggregate past the signal's Nyquist** (e.g., daily means erase an M2 tide). |
| 9 | **Y-Axis Range** | Yes | Constrained to the signal of interest — not auto-scaled to full sensor range. |
| 10 | **X-Axis Padding** | Yes | **2–5% of the plotted time span on each side**, equal on both sides. |
| 11 | **Data Gaps** | Yes | Gaps visible (no silent interpolation — NaN-indexed plotting shows them naturally). Any fill/interpolation method must be stated; excluded intervals noted in caption if scientifically relevant. |
| 12 | **Grid** | Yes | Light background grid, **alpha 0.2–0.4**, behind the data. |
| 13 | **Spine Weight** | Yes | Spines ≥ tier minimum line weight (**Paper ≥ 1 pt · Presentation ≥ 1.5 pt · Poster ≥ 2 pt**). |
| 14 | **Line Weight** | Yes | Data lines ≥ tier minimum (same values as #13), consistent across series. |
| 15 | **Resolution/Format** | Yes | PNG at ≥ the declared sizing tier's minimum DPI. |
| 16 | **Colorblind Safety** | Yes | Okabe-Ito (discrete) / viridis (continuous), or a named equivalent (IBM, Paul Tol). All distinctions perceivable under deuteranopia/protanopia. |
| 17 | **Data Provenance** | Yes | Caption or legend identifies instrument, data source, and deployment period for every plotted series. Derived data cites the sibling project and output file. |
| 18 | **Multi-Panel Labels** | If multi-panel | Panels labeled consistently at standard position and font size. |
| 19 | **Layout Spacing** | Yes | Plot area explicitly positioned to reserve space for caption below and title above. Zero clipped labels/annotations in the exported file. |

## Scorecard Template

Track compliance per figure in the project's `specs/timeseries-scorecard.md`:

```
| Figure | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8a | 8b | 8c | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | Notes |
|--------|---|---|---|---|---|---|---|----|----|----|---|----|----|----|----|----|----|----|----|----|----|-------|
```
Mark **P** = pass, **F** = fail, **–** = not applicable (per shared standards).
