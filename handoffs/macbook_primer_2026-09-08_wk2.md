*AI-generated draft (Claude, Anthropic), for review. Written on the MacBook on 2026-09-08, reconciling three iMac sittings that left index rows but no primer.*

# Handoff to the MacBook, 2026-09-08 evening

**Both courses meet tomorrow, Wed Sep 9.** GEOL 16 meeting 3 at 10:45, GEOL 333/714 Wk 2 at 4:35.

**Why this file exists.** Today's three iMac sittings each appended an index row and pointed at `PUNCHLIST.md`. No note was addressed to this machine, and the punch list's own **READ FIRST block is dated Sep 6**, two sittings behind, so it does not describe the current state. This reconciles them.

## Do this first

**Everything is now pulled and clean, but three repos were badly stale here** and were pulled as part of writing this: `geol-16-fall-2026` was **38 commits behind**, `geol-333-714` **36 behind**, `nsf26_512_ai_datasets` **1 behind**. If a fourth machine touched anything, check again before trusting a working tree on this box.

| Repo | Head |
|---|---|
| `class_dev/geol-333-fall-2026` | `2d24bb8` |
| `class_dev/geol-16-fall-2026` | `5545e99` |
| `class_dev/geol-333-714` (public) | `bcc41cb` |
| `claude-config` | `3800313` |
| `proposal_dev/proposals_2026/nsf26_512_ai_datasets` | `c19a9c4` |

## What this machine can and cannot do, measured today

**`uv run pytest` does not run here at all.** It dies during collection, not on assertions: `tests/test_daily_inquiry_layout.py` pulls in WeasyPrint at import time and `libgobject-2.0-0` is absent, so the run aborts with `1 error` and **zero tests execute**. The usable command is:

```
uv run pytest -q --ignore=tests/test_daily_inquiry_layout.py
```

which gives **5 failed, 116 passed, 3 skipped, 3 errors**. Every one of those eight is environmental, and they are the same family every time: the two syllabus-tagging tests and the instructor-pack build need WeasyPrint; the three `test_exit_slip_sheets` errors are the same library reached through a fixture; `test_retirement_grep` compares built-page timestamps against sources and a fresh clone loses that ordering. **None of them indicate a problem with the work.** Treat any other failure as real.

**`build_handout_pdfs.py` works here.** It runs through playwright rather than WeasyPrint, verified today by rebuilding the Wk 2 runsheet. So runsheet and handout rebuilds are fine on this machine; syllabus PDFs and instructor packs are not.

**The 714 page map is present** (`scripts/brightspace_pages.json`), so the HTML build guard should pass, but `brightspace_pages_333.json` has never existed here. Check before building the 333 set.

## Tomorrow, Wed Sep 9: what is actually owed

From the punch list's before-Wednesday list, as amended through today. **Almost all of it is your hands, a browser, or a printer**, and none of it is mine.

| | Item |
|---|---|
| W1 | Paste `page_wk2`, both shells. Use the Instructions **source view**, not Select All: a paste was shown to merge rather than replace |
| W2 | Paste `assignment_hw1` and the three JP1 pages, both shells. **JP1 claims close at this meeting** |
| W3 | Print exit slips. Rebuilt 2026-09-07 for the ten-minute change. 25 sheets, 50 pages, duplex, flip long edge |
| W4 | Print the collection paper, now **three artifacts**: `pendulum_data_collection_sheet.pdf` (2 pp, one per student, 20 duplex), `station_timing_sheet.pdf` (2 pp, one per station, 6 duplex), `marking_slips.pdf` (1 copy, 2 pp, cut into five) |
| W4b | Print `class_data_plot_sheet.pdf`, 1 page, one per student, single sided, ~20 copies |
| W4c | **Say the JP1 round fix out loud.** The named round assignments were never posted, so no graduate student knows their round, and `assignment_jp1.md` told them the assignments went up Sep 2. Ruled: address it in announcements, solve it Thursday. Grad claims stay open until Thursday; 333 groups still claim tomorrow |
| W5 | Daily-inquiry sheets, done. 28 sheets, 56 pages, duplex on **long** edge, nothing cut |

**Still owed by you and recorded as never sent: the two JP1 Paper List page URLs**, one per shell.

## The timing question is closed

**Nothing is cut. The meeting will run out of time and that is fine** (instructor, 2026-09-08). The sequencing rehearsal put the plan near 170 minutes against 150; he was offered the pendulum derivation (§4) and the free-air-through-Burger block (§6 to §8) and declined both.

This is the standing clock-follows-the-lesson policy, not a new call. The plan degrades gracefully on its own: sections run in written order, so what the evening does not reach is §6 onward, which is Week 3's topic in the week that owns it.

**Do not raise it again.** It was raised twice on 2026-09-08, and the same thing happened for Week 1 on 2026-09-01 after he had already ruled. Full entry at the top of `PUNCHLIST.md`.

## What changed today, in one place

**GEOL 333/714, Wk 2.** Sections 3 to 6 of the runsheet were rebuilt into one shape you ruled while walking section 4: **figure, then asks, then a HAS TO LAND block**, with a one-line answer cue beside every ask. Reading copy `runsheet_wk2_2026_09_08_v39.pdf`, 23 pages. Three real holes were closed: `x = l*theta` was the only step introducing `l` and nothing asked for it, free-air was derived before the datum existed, and the `GM/R^2 = g` substitution, the only step that makes the number computable, was asked by nothing.

**The opening became a real §0**: five Week 1 terms asked of the room with a one-line support each, the statistics stated rather than asked because the survey says the room does not own them, what they owed since Sep 2, the roadmap, and eight announcements spoken with nothing written. **Terminology is ruled: the piece at the start is the catalyst question, formative; the piece at the close is the quiz, summative. "Card" is retired.**

**The collection activity is now blind.** You do not pre-mark strings. Stations build their own apparatus and cross-mark each other's, A marks B round to E marks A, from one shared set of near-round targets (40.3, 60.5, 79.8, 100.6, 119.4 cm) chosen so lengths stay spread while the decimal cannot be guessed. Marks are numbered from the bob up and no distance appears on a student sheet. **You are the only person who knows the true lengths, which is what makes accuracy measurable.**

**This resolves the 1.0127 m problem from Sep 2 by moving it rather than removing it.** The 1.27 cm bob correction changes hands: the students now apply it themselves. Worth checking that the three artifacts still asserting `l = 1.000` were updated or retired, because that was the open item and I have not verified it on this machine.

**GEOL 16 meeting 3** went from nothing to a finished 33-slide deck with five figures built in the house style: isostasy, three ways heat moves, the heat engine, the geothermal gradient, mantle convection. Four defects were caught and each has a guard now, including a save that crossed a rebuild and silently discarded four slides, which is why every deck script refuses to run while PowerPoint holds a `~$` lock. **The first geotherm figure was wrong in a way that looked right**, drawing a straight line between two anchors that put the base of the lithosphere near 1104 C and appeared to contradict the assigned reading; the rebuild uses the digitised curve from PG 9.2's own Figure 9.2.1.

## Open, none of it blocking tomorrow

1. **Wk 2 sections 7, 8, 9, 10 and both reserves have never been worked.**
2. **Three rulings owed:** the `2*pi*sqrt(m/k)` import that this course derives nowhere; the 15 degree amplitude cap, which biases `g` low by 0.86 percent; and the timing above.
3. The shell-theorem figure on the practice sheet overflows its canvas.
4. Six items in the punch list's 09-08 block, led by HW1's unpropagated date and the catalyst question's "same ten swings" premise.
5. **The GEOL 16 meeting 2 posting was never finished**: `class_02_slides.pptx` still needs Save As PDF and dropping into the shared `Geol16_lectureSlidesF2026` folder. That folder is a public link, so the .pptx must not go there.
6. Older and still unruled: the A3 pre-stage bullet in Wk 1, the fuller exam description for Beat 3, `test_missing_links` skipping on map-less machines, and DRIVE-requires-SAY in the runsheet template.

## A note on this file's absence

Three sittings in one day each wrote an index row and none wrote a primer, and the block they all point at is two days stale. The index rows are long enough to carry real content but they are summaries of a session rather than a statement of where the work is, which is a different document. If the pattern continues, the punch list's READ FIRST block should be rewritten at the end of each day rather than left dated.
