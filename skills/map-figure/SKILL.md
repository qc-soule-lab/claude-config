---
name: map-figure
description: Use when creating or evaluating cartographic/map figures. Provides 14 evaluation criteria for coordinate references, scale bars, legends, colorbars, captions, and layout standards.
---

# Map Figure Rubric

*Rubric v1.1 (2026-06-12) — anchored acceptance thresholds. Canonical copy: `claude-config/skills/map-figure/SKILL.md`; project copies (e.g. `scaleworm-student-lab/specs/rubrics/`) point here.*

When creating or reviewing a map figure, apply ALL of the following criteria. Also follow the shared standards in `~/.claude/skills/figure-standards/shared-standards.md` (sizing tiers, caption technique, colorblind palette, provenance, multi-panel labels). **Score each criterion against its anchor — the anchor decides, not overall impression.**

## Criteria

| # | Element | Required | Acceptance Standard (anchor) |
|---|---------|----------|---------------------|
| 1 | **Coordinate Reference** | Yes | Lat/lon labels on axes or gridlines. |
| 2 | **Scale Bar** | Yes | Labeled bar spanning **10–20% of map width**, metric units (m or km), round number (1/2/5×10ⁿ). True meters when using a metric projection. |
| 3 | **North Arrow** | Yes | Arrow with "N" label. |
| 4 | **Classification Legend** | If applicable | Every color-coded symbol on the map appears in the legend; zero unexplained symbols. |
| 5 | **Depth/Value Colorbar** | If continuous shading shown | Colorbar with labeled quantity and unit (e.g., "Depth (m)"). Unlabeled colorbar = FAIL. |
| 6 | **Neatline Border** | Poster tier | Alternating black/white ladder border. **Required at poster tier; optional at paper/presentation tier** unless the project constitution says otherwise. |
| 7 | **Title** | Yes | Concise; technical details deferred to caption. Font size ≥ sizing-tier minimum. |
| 8 | **Figure Caption** | Yes | Fully justified (see shared standards). States data source with collection year. No orphaned line (= a single word alone on the final line). |
| 9 | **Label Legibility** | Yes | Every feature label ≥ sizing-tier minimum font; **≥ 2 pt clearance between labels** — touching/overlapping labels FAIL unless they differ in both color and weight. *PASS example: 10 pt labels, 4 features, visibly separated. FAIL example: two 8 pt labels touching.* |
| 10 | **Resolution/Format** | Yes | PNG at ≥ the declared sizing tier's minimum DPI. |
| 11 | **Projection Info** | Yes | Coordinate system named **in the caption, on the map, or both** (e.g., "UTM Zone 10N", "WGS84") — at least one, and the project constitution may require both. The PI specifies the projection before plotting; it is never assumed. |
| 12 | **Colorblind Safety** | Yes | Okabe-Ito (discrete) / viridis (continuous) / cmocean (oceanographic), or a named equivalent (IBM, Paul Tol). All distinctions perceivable under deuteranopia/protanopia. |
| 13 | **Data Provenance** | Yes | Caption or annotation cites data source and collection/publication year (e.g., "Bathymetry from 1 m AUV survey, MBARI 2025"). Derived products cite the processing chain or sibling project. |
| 14 | **Multi-Panel Labels** | If multi-panel | Panels labeled consistently at standard position and font size. |

## Scorecard Template

Track compliance per figure in the project's `specs/map-scorecard.md`:

```
| Figure | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | Notes |
|--------|---|---|---|---|---|---|---|---|---|----|----|-----|----|----|-------|
```
