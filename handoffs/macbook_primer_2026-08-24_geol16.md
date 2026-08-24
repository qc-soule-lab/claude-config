*AI-generated draft (Claude, Anthropic), for review. Machine-transfer primer written on the [iMac] 2026-08-24 for picking up GEOL 16 on the [MacBook]. Everything below is committed and pushed unless it says otherwise.*

# GEOL 16 handoff, iMac to MacBook, 2026-08-24

## Read these first, in this order

1. `~/repos/class_dev/geol-16-fall-2026/PUNCHLIST.md`, top section. It holds the live critique queue for the meeting 2 deck.
2. `docs/lesson_plans/records/agent_prep_plan_2026_08_24.md`. What three agents found and the queue of decisions.
3. `docs/quizzes/daily_inquiry_plan.md`. The Daily Inquiry design, rewritten today and now the single current spec.
4. `docs/lesson_plans/meetings/meeting_02_sources.md`. Claim-by-claim provenance for the meeting 2 deck.

## The one rule that changed how this project works

**His answer to "how do you know that" can never be "because Claude put it there."** Every factual claim on a slide carries a status: `MEMORY` (asserted from model recall, no source consulted), `COMPUTED`, `OWN`, `SOURCED`, or `VERIFIED`. **Nothing ships at `MEMORY`.** The gate is his lesson prep: before teaching a meeting he walks that meeting's sources sheet and confirms every claim, marking rows `VERIFIED` with initials and a date. Verification carries forward between offerings, so the burden is front-loaded.

Two commands:

```
uv run python scripts/check_sources.py --checklist        # his prep list, slide order
uv run python scripts/check_sources.py --require-verified # the pre-teaching gate
uv run python scripts/pg_lookup.py 9.2 --words 150        # what a PG section actually says
```

`pg_lookup.py` reads the textbook from **Dropbox**, `Geo016_F26/textbook/earle_physical_geology_2ed.pdf`, 827 pages. It syncs, so it should be on the MacBook already; if not, wait for Dropbox before running it. Do not fetch the book from opentextbc.ca, which returns 403 to automated requests.

## Where the work is

- **Repo:** `~/repos/class_dev/geol-16-fall-2026`, branch `main`, pushed.
- **Decks:** Dropbox `.../QC-GEOL 16/Geo016_F26/decks_fall2026/`. `geo16_f26_mtg01.pptx` is 28 slides, `geo16_f26_mtg02.pptx` is 31. Backups sit alongside as `.pre_revision`, `.pre_overflow`, `.s25_backup`, `.pre_droptext`.
- **Deck scripts:** now in the repo at `scripts/deck/`, with a README explaining what each did and the two ways a deck was broken while learning. They used to live in a session scratchpad, which is why they are here: a scratchpad does not cross machines.

## Working mode he asked for, and it works

**Slide by slide, two steps per slide.** Step 1 is content: propose options, he rules. Step 2 is facts: list every verifiable claim on that slide, having sourced them first, and he confirms each one. A slide is not done until both steps are.

**During a review run, log rather than apply.** He said it explicitly today: accumulate approved items in the punch list and batch-build when he calls for it. Do not fix things mid-walk.

**Ask one question at a time**, as an options list with a recommendation first. He often answers with a note instead of picking an option, and the note is the ruling.

**For pushes, prompt one page at a time and load the clipboard**; he replies "next". That ran seven items today without friction.

## State of the walk

Slides 1 through 4 of meeting 2 are content-complete. **Resume at slide 4 step 2** (fact check the four objectives against the twelve on the syllabus), or jump to slide 5, where the Tambora facts are already sourced and waiting for confirmation.

**His own hand edits are in the deck**: slide 4 is 32 pt, and he removed two commas. **Never re-apply a script's font table over a slide he has adjusted.** 32 pt is now the calibration in the repo CLAUDE.md.

**Logged and not applied** (punch list item 0b and neighbours): rejoin the split yellow run on slide 4, where his retype left "layers and" highlighted; drop the parallel comma in objective 4; make slide 28 match slide 4; sync his wording into `meeting_02_deck_plan.md`, which still carries the pre-edit text. Also open: the slide 23 sequence complaint with no specifics given, the four scaffold images, the cruise video drop-in, and the ash-ring figure.

## What has to exist before he teaches

**Before Sep 2, hard:** slide 3 tells students to open **EX 02**, which does not exist. The Daily Inquiry module does not exist either. Build order: create the flat "Daily Inquiry" content module, capture its real URL (do not guess the ID pattern, it was four off last time), upload `brightspace_documents/catalyst_sheet.pdf` and capture its share link, paste `docs/brightspace/html/daily_inquiry_page.html`, add a navbar link named Daily Inquiry (the shared CUNY navbar must be copied before it can be edited), then build the exit-slip template quiz and copy it to `EX 02`.

**Before Sep 10, at sea:** `EX 04` through `EX 08` fully configured. Place the pre-sail batch in **forward** order inside the module, or Sep 14 opens with EX 08 on top; from meeting 9 onward, newest-at-top and today-at-top are the same thing.

**Also dated:** the heat-transfer reading upload, Data Lab 1 is promised on the meeting 3 page and is not in the Dropbox activities folder, and the Kelley recording has still never been located.

## Live shell state, all pushed today

Seven items went live: `page_mtg01`, `page_mtg02`, `page_mtg03`, `page_mtg07`, `schedule` (now links the textbook at the top with the CC BY line), `module1_overview` (restored after he overwrote it mid-run), `module2_overview`. The syllabus PDF was overwritten in place in Dropbox so its share link did not change. Every change-log row is marked pushed.

## Readings, ruled today

- **Meeting 2:** Chapter 1 for background, then 9.1 and 22.1 to 22.3. Replaced 1.4 to 1.6, which teach minerals and geologic time.
- **Meeting 3:** adds 9.4, Isostasy, after that topic moved here.
- **Meeting 7:** the textbook has no hydrothermal vent section at all, so two public-domain NOAA pages plus the UW Axial Caldera page as a link. This is also what finally gives Module 2 quiz item Q9 a source.
- **Deferred to October by his decision:** meeting 17 assigns a section titled "Waves" that never says tsunami (content is in 11.4), meeting 19 assigns prediction and mitigation for induced seismicity, meeting 22 has no reading, and `assessment_qa_plan.md` cites 10.2 for magnetic stripes when they are in 10.3, across five items. All in `records/pg_reading_audit_2026_08_24.md`.

## Things I got wrong today, so they are not repeated

- Snow fell in New England in **July** 1816, not June.
- **No agency source supports the Tambora explosions being heard 1,500 km away.** That slide was rebuilt on NASA's ash distance, 1,300 km. Tambora is on Sumbawa, not Sumatra.
- The Kola borehole is **12,260 m** per USGS. The 12,262 m figure I drafted appears on no agency page.
- The cable is a **900 km network with a 480 km branch**, not "about 500 km".
- `pg_lookup.py` originally missed four real sections and invented one from a figure caption. It now takes the section list from the book's contents pages.
- **A status code is not proof a page exists**: `oceanservice.noaa.gov/facts/chemosynthesis.html` returns 200 while serving a not-found body.

## Tooling notes for the MacBook

- **Scripted PowerPoint PDF export triggers a macOS folder-access prompt and then fails with error -9074.** Do not use it. Read decks with `python-pptx` and ask him to export if a render is needed.
- Check for `~$` lock files in `decks_fall2026/` before editing a deck, and confirm with AppleScript that PowerPoint has nothing open.
- Tests: 120 passing, ruff clean. `scripts/deck/` is excluded from ruff on purpose.
