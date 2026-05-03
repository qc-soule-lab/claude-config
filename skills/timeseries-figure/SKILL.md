---
name: timeseries-figure
description: Use when creating or evaluating time series plots. Provides 19 evaluation criteria for axis labels, legends, captions, data gaps, temporal aggregation, and layout standards.
---

# Time Series Figure Rubric

When creating or reviewing a time series figure, apply ALL of the following criteria. Also follow the shared standards in `~/.claude/skills/figure-standards/shared-standards.md` (sizing tiers, caption technique, colorblind palette, provenance, multi-panel labels).

## Criteria

| # | Element | Required | Acceptance Standard |
|---|---------|----------|---------------------|
| 1 | **Axis Labels** | Yes | Both axes labeled with quantity and unit in parentheses (e.g., "Temperature (°C)"). Bold. Font size per sizing tier. |
| 2 | **Dual-Axis Clarity** | If applicable | Secondary y-axis labeled and color-matched to its data series. Units stated. |
| 3 | **Date Formatting** | Yes | Clean date ticks at regular intervals appropriate to the time span; no crowding or overlap. Horizontal or slightly rotated labels. |
| 4 | **Classification Legend** | Yes | All plotted series identified by color, style, and descriptive label. Framed with high alpha for readability over gridlines. |
| 5 | **Event Annotation** | If applicable | Key events marked with vertical line + text label. Consistent visual language across figures (e.g., red dashed = eruption, gray dotted = cruise/servicing). Bold annotation text. |
| 6 | **Title** | Yes | Concise 1-2 line title identifying the phenomenon, time period, and location. Font size per sizing tier. |
| 7 | **Figure Caption** | Yes | Renderer-based fully justified (see shared standards). States axis quantities, identifies all data series by name and source, summarizes the key scientific observation. |
| 8 | **Temporal Aggregation** | Yes | Aggregation level appropriate to the signal (daily means, hourly, raw). Stated in caption or axis label. Data trimmed to scientifically meaningful window (exclude instrument recovery artifacts, pre-deployment noise). |
| 9 | **Y-Axis Range** | Yes | Constrained to focus on the signal of interest — not auto-scaled to full sensor range. |
| 10 | **X-Axis Padding** | Yes | Balanced padding on both sides of the data, proportional to the time span. |
| 11 | **Data Gaps** | Yes | Gaps in the record are visible (no silent interpolation). Excluded intervals noted in caption if scientifically relevant. |
| 12 | **Grid** | Yes | Light background grid (alpha ~0.3) to aid value reading without obscuring data. |
| 13 | **Spine Weight** | Yes | Plot bounding-box spines meet minimum line weight for the sizing tier. |
| 14 | **Line Weight** | Yes | Data lines meet minimum weight for the sizing tier. Consistent across all series. |
| 15 | **Resolution/Format** | Yes | PNG at minimum DPI for the declared sizing tier. |
| 16 | **Colorblind Safety** | Yes | Okabe-Ito or equivalent palette. All distinctions perceivable under deuteranopia/protanopia. |
| 17 | **Data Provenance** | Yes | Caption or legend identifies instrument, data source, and deployment period for every plotted series. |
| 18 | **Multi-Panel Labels** | If multi-panel | Panels labeled consistently at standard position and font size. |
| 19 | **Layout Spacing** | Yes | Plot area explicitly positioned to reserve space for caption below and title above. No clipping of labels or annotations after export. |

## Key Conventions

- **Event annotations**: Maintain consistent visual language within a project. Red dashed = eruption, gray dotted = cruise/servicing. Document in project constitution.
- **Temporal aggregation**: The correct level depends on the science. Daily means suit multi-month records; hourly or raw for tidal/event detection. State what was used.
- **Data gaps**: pandas/matplotlib naturally show gaps when plotting datetime-indexed series with NaN. Do not fill or interpolate unless the method is stated.
- **Provenance**: At minimum, name the instrument and deployment period. For derived data from sibling projects, cite the project and output file.

## Scorecard Template

Track compliance per figure in the project's `specs/timeseries-scorecard.md`:

```
| Figure | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | Notes |
|--------|---|---|---|---|---|---|---|---|---|----|----|----|----|----|----|----|----|----|----|-------|
```
