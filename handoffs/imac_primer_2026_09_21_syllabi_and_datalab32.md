*AI-generated draft (Claude, Anthropic), for review. Written at the end of the 2026-09-21 iMac session, which ran alongside a second terminal working the same two repos. Every file path and commit below was checked against the repos.*

# Morning list: syllabi to the department, and one live quiz edit

Three courses moved tonight. The department submission is the thing with a
deadline attached, and it is one edit away from done.

---

## 1. First thing: the 333/714 renumber, then rebuild

**This is the only thing between you and a submittable 333/714 pair.**

Both syllabi are now correct on everything the graduate advisor raised. Both are
still wrong on homework numbering, because the sources still list HW3 (Orca
gravity), which you cut 2026-09-18.

The line-by-line edit table is already written:
`geol-333-fall-2026/docs/lesson_plans/records/syllabus_renumber_and_rebuild_handoff_2026_09_20.md`

Canonical target, from `assignment_calendar.md`: six assignments, HW0, HW1,
HW2a, HW2b, HW3 (Diurnal, magnetics), HW4 (Travel-Time, refraction).

Order matters. **Edit both sources, then rebuild once.** The PDFs were rebuilt
tonight so you could read the advisor's changes, so they currently look current
and are not. They still say "Seven homework assignments" and still name HW3:
Orca Gravity.

`uv run python scripts/build_syllabus.py` builds both.

## 2. Reply to the Data Lab 3.2 student, and fix the live stems

A student could not find coordinates on the Ocean Data Lab map. They were right.
That map has no coordinate readout of any kind: no graticule, no mouse-position
control, no popups. Its only controls are a legend and a draw tool.

This was an error in the v02 rewrite, which had asked Q3 and Q4 for latitude and
longitude on the reasoning that Data Lab 1.3 taught coordinates. Lab 1.3 taught
them in GeoMapApp, which displays them. Different tool.

**Source is fixed and committed** (`geol-16-fall-2026` `e2c2bde`). Q3 and Q4 now
ask for position relative to the coastline and the marked rectangle.

**The live D2L stems for Q3 and Q4 are not fixed.** Due Mon Sep 28, 10:45 AM, so
there is room, but anyone working it now hits the same wall. A draft reply to the
student was written in-session for reference; the substance is that the map has
no coordinate readout, so describe the location against the coast and the
rectangle, and answers in that form get full credit.

## 3. GEOL 16 is ready to submit

Nothing owed. The other terminal fixed the OSDA office name and both dead URLs
and rebuilt the PDF; verified by extracting the PDF text. The expired September
10 extra-credit offer is gone too.

`geol-16-fall-2026/docs/syllabus/syllabus_geol16_fall_2026.pdf`

## 4. GEOL 793.3 is ready to submit, with two cosmetic leftovers

It is **793.3, not 795.3**, section **56502**. The course number was wrong in the
syllabus, CLAUDE.md, PUNCHLIST and pyproject; all four are corrected and the
PUNCHLIST item asking someone to confirm the number is closed with the answer.

`geol-795-makayla-fall-2026/docs/syllabus/syllabus_fall_2026.pdf`
Note the directory still says 795. Renaming it is a separate decision and would
break the planned GitHub remote name.

Leftovers, neither blocking: the literature review still says `Target length:
TBD`, and its due date reads "end of September" where you said next week.

---

## What the advisor's edits actually were

**Title.** Both syllabi now read `GEOL 333: Geophysics` and `GEOL 714:
Geophysics`, matching the bulletin. No Minor Change Form needed. Your ruling was
to retitle both rather than file a motion.

**Prerequisites.** The 714 syllabus had been carrying the undergraduate set
(GEOL 101, PHYS 1214/1211 or 1454/1451, MATH 141/151), almost certainly from the
2026-05-29 split. Removed. GEOL 333 keeps its line.

**Still unverified:** the advisor also said the syllabus has to reflect the
bulletin *description*. Both syllabi carry a description at line 25 beginning
"Introduction to gravity, magnetic, seismic, ground-penetrating radar...". Nobody
has compared that paragraph to the bulletin. Worth a glance while the bulletin is
open.

**Not swept:** the old title "Geophysical Exploration Methods" appears in 47
files in `geol-333-fall-2026`, including `docs/brightspace/overview.md`, the five
HW rubrics, `literature/README.md`, and the course banner image whose artwork
likely has it rendered in. Only the two syllabi were retitled, because the
compliance requirement is about the submitted document and renaming the course on
pages students have used for four weeks is a communication decision, not a fix.

---

## Two sessions, one working tree: three commits got swept

Both terminals were writing to `geol-16-fall-2026` and `geol-333-fall-2026`
tonight. A broad `git add` from the other session picked up this session's
uncommitted files three separate times, landing them in commits whose messages
describe unrelated work:

| Work | Landed in |
|---|---|
| Data Lab 3.2 v02 quiz, catalogue, test | `f830dad` "Class 5 glossary terms" |
| `data_lab_3_2_key_stats.py` | `6365d59` "Summative prompt for Class 4" |
| Syllabus retitle + 714 prerequisite removal | `a6ece25` "De-identified student work may be examined with Claude" |

Nothing was lost and every suite passes. The cost is the audit trail: searching
the log for when the syllabus was retitled, or when Data Lab 3.2 was repaired,
turns up nothing.

Same cause bit the citations. A syllabus assessment written at 22:00 cited four
`PUNCHLIST.md` line numbers in `geol-16-fall-2026` that had already moved by the
time they were checked twenty minutes later.

**Worth adopting:** partition by repo rather than by terminal, and stage by
explicit path rather than `git add -A`. The two notes and every commit this
session made were staged file by file.
