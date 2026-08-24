*AI-generated draft (Claude, Anthropic), for review. Written on the [MacBook] 2026-08-24 at the end of a GEOL 16 meeting-2 slide walk. Everything described is committed and pushed.*

# GEOL 16 handoff, MacBook, 2026-08-24 (end of session)

## Read these first, in this order

1. `~/repos/class_dev/geol-16-fall-2026/PUNCHLIST.md`, top block. The session-end section is first and points at everything else.
2. `docs/lesson_plans/meetings/meeting_02_sources.md`. The provenance sheet, now the live record of what is verified and what is not.
3. This file, for the conventions that changed today.

Pull first: `cd ~/repos/class_dev/geol-16-fall-2026 && git pull --ff-only` (branch `main`, through `6d1e5a1`).

## Where the walk stands

**Meeting 2 deck is 32 slides.** Slides 5, 6 and 7 are built and in the deck. Slide 8 has a figure built but **not placed and not seen by him**.

| Slide | State |
|---|---|
| 5 "Tambora / April 10, 1815" | Built. Full-bleed ISS caldera photo, name and date only over a contrast band. **Eruption date VERIFIED DS.** |
| 6 "Tambora, 1815: the numbers" | New slide. Four facts at 32 pt. **All three sourced facts VERIFIED DS.** |
| 7 "How far the ash went" | Built. Two-panel ash-distance figure placed, title kept, background white. Facts still unsigned. |
| 8 "The year without a summer" | **Figure built, NOT placed.** Awaiting his look and his ruling. |

**Slide numbers after 5 all shifted +1** when slide 6 was inserted. Old to new: 6→7, 7→8, 8→9, 23→24 (the cable), 28→29 (objectives recap), 30→31 (catalyst hand-in), 31→32. Punch list items written before today still carry the old numbers.

## Three conventions changed today, all his rulings

1. **Claude looks at every image before it goes on a slide.** The repo CLAUDE.md had said Claude cannot see images, and the whole image rule was built around written-down provenance as a result. That was wrong and it cost something real: the ISS photo went onto slide 5 unexamined, and the first person to look at it was him, asking what the black half of the frame was (it is the caldera's own shadow, and it is now a teaching point in the notes). Provenance still proves a picture is what it claims to be; looking catches the sourced-but-unreadable case. Corrected in `CLAUDE.md` and in the sources sheet.
2. **Speaker-note sources are written twice.** PowerPoint's Notes pane does not activate hyperlinks; they work only in View > Notes Page and in PDF exports. So each source is a clickable page title **and** the bare URL on the next line, with the scheme, to copy. His suggestion after the first attempt gave him dead links. Helper: `write_notes()` in `scripts/deck/notes_hyperlinks.py`.
3. **A claim ruled off a slide is marked `CUT`**, not left at `MEMORY`. Left at `MEMORY` it blocks the gate forever and the gate stops being worth running.

## The provenance gate is now trustworthy, and nearly green

`uv run python scripts/check_sources.py` reports **1 problem across 43 tracked claims**. It reported 8 across 28 at the start of the session, and most of that was the gate lying in both directions:

- Three `SOURCED` rows had quotes but no links; the 08-24 sweep had found the sources and nobody moved its URLs into the sheet.
- **Two parser bugs were hiding rows.** A row was dropped whenever its table's subject column was not literally named `Claim`, so the announcements table (`Box`) and the reading table (`Source`) were invisible: **13 of 41 rows were never being checked**, and a `MEMORY` claim in one of those tables would have gone the same way. Separately, `VERIFIED` was required to carry a URL, which false-flagged five rows he had verified against the syllabus and D2L settings.
- A refused probe on a `VERIFIED` or `OWN` row is now a warning, not a blocker. `usgs.gov` and `ssd.jpl.nasa.gov` both refuse automated fetches from this machine, so treating every refusal as rot would train him to ignore the output.

**The one remaining problem is real: the Tambora death toll.** USGS ">70,000" and NOAA "11,000 plus >100,000" are both recorded but the page behind each quote never was. The two candidates sit in the slide 6 notes with copyable URLs; opening them settles it. **It was deliberately left at `SOURCED` rather than `VERIFIED` when he signed off slide 6**, because the on-slide wording carries no number and marking the row verified would have closed the gate's last problem without resolving the attribution.

## Slide 8, the decision waiting for him

`outputs/figures/meeting_02_1816_summer.png`, from `scripts/build_1816_anomaly_figure.py` (6 tests). Every summer in HadCET 1659-2025 as a June-August anomaly, 1816 marked.

- **Headline is baseline-independent: 1816 was the 3rd coldest of 367 summers**, -1.93 °C against the 1961-1990 normal.
- **Berkeley Earth was rejected on a fact: its North America series begins in 1823** and cannot show 1816. Almost no instrumental record reaches that year, which is why this is central England. The figure states "Central England, not New England" on its face; the slide's New England details stay separately sourced USGS/NOAA text.
- **The baseline was treated as the integrity trigger it is.** 1961-1990 is the dataset's own published climatology, not a window chosen to deepen the anomaly; the neutral alternative centred on 1816 moves the value by 0.02 °C, and a test fails if those ever diverge by more than 0.1 °C.
- **1695 and 1725 are marked because they were colder with no eruption.** A figure showing only 1816 would teach that a cold summer proves a volcano. A test asserts those two are still the only colder years.

**Ask him:** does it go on slide 8, and does the title stay. Then the image question, which has an unusual answer: **no public-domain 1816 New England image exists at all.** Every candidate is European, so a caption has to say so, and the NOAA-looking 1816 anomaly figure in circulation is a Wikimedia user's CC BY-SA plot that cannot be credited to NOAA.

## Working mode, unchanged and worth restating

- **Slide by slide, two steps.** Step 1 content: propose, he rules. Step 2 facts: list every claim pre-sourced, he confirms each individually. A slide is not done until both are.
- **Log rather than apply during a walk.** Accumulate approved items; batch-build when he calls for the batch. He does call for it mid-walk, so listen for "go ahead and do this one".
- **One question at a time**, options with a recommendation first. He often answers with a note rather than picking, and the note is the ruling.
- **Deck edit loop:** close PowerPoint (AppleScript, save first), back up alongside as `.pre_<thing>`, edit with python-pptx, verify, reopen with `open`. Never delete slides before inserting; deleting frees part names that python-pptx reuses and PowerPoint then repairs the file.
- **Never re-apply a script's font table over a slide he has adjusted.** Slide 4 is 32 pt because he set it by hand, and 32 pt is now the calibration for a four-line slide.

## Machine notes [MacBook]

- **The GEOL 16 Dropbox tree is selective-sync'd per folder.** `QC-GEOL 16/` was entirely absent at session start; `decks_fall2026/` was synced first. If it happens again the order is `decks_fall2026/`, `brightspace_documents/`, `activites/OOIDatalab2/`, `Readings/`, then the 257 MB `textbook/` last. **Never sync `Geo016_S25/` or `embargoed_GEOL16/`.** As of session end `brightspace_documents/`, `activites/` and `Readings/` were still not synced, so the Daily Inquiry catalyst sheet and the heat-transfer reading are still out of reach here.
- **The repo was not cloned on this machine at all** before today. It is now, at `~/repos/class_dev/geol-16-fall-2026`.
- **`python-pptx` was never a declared dependency** even though `scripts/deck/` needs it, so a fresh clone could not open a deck. Added, along with `cartopy` and `pyproj` for map figures (cartopy built from source in about 20 seconds; worth it for a course with plate boundaries, epicentres and hazard maps still to come).
- **No headless renderer here** and scripted PowerPoint PDF export fails with -9074, so **slide 7 was never rendered before he saw it**; its geometry was verified numerically only. Worth confirming it looks right.
- **A bug caught in the slide 7 build worth not repeating:** EMU and inches were mixed in a size-clamp branch and produced a picture 5.6 million inches tall. Restored from the backup; the arithmetic stays in EMU now.

## Deadlines, unchanged

- **Mon Aug 31**: first class. Meeting 1 has still never been through the two-step walk, and its historical opening was drafted the same way the Tambora block was, which is the block that turned out to hold a wrong month, an unsupported audibility claim and two claims that had to be cut.
- **Wed Sep 2**: meeting 2 taught. Slide 3 tells students to open **EX 02**, which does not exist yet, and the Daily Inquiry module does not exist either. That is the hard build, and it is untouched by this session.
- **Sep 10-30**: at sea, five meetings live from the ship. `EX 04` to `EX 08` configured before sailing.

## State at session end

140 tests pass, ruff clean, working tree clean, `main` pushed through `6d1e5a1`. The deck is closed. Backups alongside it: `.pre_slide5`, `.pre_notelinks`, `.pre_slide7`.
