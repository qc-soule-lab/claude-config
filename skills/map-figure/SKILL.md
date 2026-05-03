---
name: map-figure
description: Use when creating or evaluating cartographic/map figures. Provides 14 evaluation criteria for coordinate references, scale bars, legends, colorbars, captions, and layout standards.
---

# Map Figure Rubric

When creating or reviewing a map figure, apply ALL of the following criteria. Also follow the shared standards in `~/.claude/skills/figure-standards/shared-standards.md` (sizing tiers, caption technique, colorblind palette, provenance, multi-panel labels).

## Criteria

| # | Element | Required | Acceptance Standard |
|---|---------|----------|---------------------|
| 1 | **Coordinate Reference** | Yes | Lat/lon labels on axes or gridlines. |
| 2 | **Scale Bar** | Yes | Labeled distance in appropriate units (m or km). True meters when using a metric projection. |
| 3 | **North Arrow** | Yes | Arrow with "N" label. |
| 4 | **Classification Legend** | If applicable | All color-coded symbols explained. |
| 5 | **Depth/Value Colorbar** | If continuous shading shown | Colorbar with labeled quantity and unit (e.g., "Depth (m)"). |
| 6 | **Neatline Border** | Recommended | Alternating black/white ladder border. Required for poster-tier maps; optional for paper/presentation tier. Projects may override in constitution. |
| 7 | **Title** | Yes | Concise; technical details deferred to caption. Font size per sizing tier. |
| 8 | **Figure Caption** | Yes | Renderer-based fully justified (see shared standards). States data source with collection year. No orphaned lines. |
| 9 | **Label Legibility** | Yes | Feature labels meet sizing tier minimum. No overlapping labels. |
| 10 | **Resolution/Format** | Yes | PNG at minimum DPI for the declared sizing tier. |
| 11 | **Projection Info** | Yes | Coordinate system explicitly stated in caption or on map (e.g., "UTM Zone 10N", "WGS84"). The PI specifies the projection; it is never assumed. |
| 12 | **Colorblind Safety** | Yes | Okabe-Ito or equivalent palette. All distinctions perceivable under deuteranopia/protanopia. |
| 13 | **Data Provenance** | Yes | Caption or annotation cites data source and collection/publication year (e.g., "Bathymetry from 1 m AUV survey, MBARI 2025"). |
| 14 | **Multi-Panel Labels** | If multi-panel | Panels labeled consistently at standard position and font size. |

## Key Conventions

- **Projection**: The coordinate system must be explicitly identified by the PI before use. Never assume a projection — always confirm first.
- **Neatline**: Required at poster tier, recommended otherwise. Alternating black/white ladder style.
- **Provenance**: At minimum, name the dataset and its year. For derived products, cite the processing chain or sibling project.

## Scorecard Template

Track compliance per figure in the project's `specs/map-scorecard.md`:

```
| Figure | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | Notes |
|--------|---|---|---|---|---|---|---|---|---|----|----|-----|----|----|-------|
```
