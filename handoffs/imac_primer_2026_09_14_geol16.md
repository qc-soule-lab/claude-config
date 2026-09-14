*AI-generated draft (Claude, Anthropic), for review. Written on the MacBook on the evening of 2026-09-14, after GEOL 16 meeting 4, for the iMac session that follows. Repo states are read from the repos; the meeting facts are the instructor's report the same day.*

# iMac primer, 2026-09-14

**Wednesday Sep 16 is two meetings: GEOL 16 meeting 5 at 10:45 in PH 115, and GEOL 333/714 Week 3 in the evening.** GEOL 16 has no deck for Wednesday. That is the whole of this note.

## First five minutes on the iMac

1. **Pull.** All four repos are pushed and nothing is LOCAL.

```
cd ~/repos/class_dev/geol-16-fall-2026   && git pull     # main, a2f8e19
cd ~/repos/class_dev/geol-333-fall-2026  && git pull     # restructure-rebalance-2026-06-21, 604f368, unchanged today
cd ~/repos/class_dev/geol-333-714        && git pull     # main, 1345f08, unchanged today
cd ~/repos/claude-config                 && git pull     # main
```

2. **Let Dropbox finish syncing before opening anything.** Three things were written to Dropbox from the MacBook today and the iMac has to receive them: `Class Meetings 2026/Meeting 05 - mid-ocean ridges/` (new folder, holding `geo16_f26_mtg05_magnetics_seed.pptx`, moved out of Meeting 04), `Meeting 04 - plate tectonics/class_04_slides.pdf` (34 pages), and the deck `geo16_f26_mtg04.pptx` as it was closed after the lecture.

3. **Tests.** GEOL 16 should be fully green on the iMac. On the MacBook it is 427 passed, 4 skipped; the extra skip is the WeasyPrint exit-slip test, which now skips cleanly where the C library is missing rather than failing collection.

## What happened Monday

Meeting 4 reached **slide 34 of 34**, the first deck this term to finish. The exit slip ran. **Three catalyst questions ran** against a deck with two catalyst slides and a sheet printed with two boxes, so one question ran off-deck; its text is owed for `meeting_04_catalyst_questions.md`. His ruling: **slides 23 onward repeat at meeting 5.**

Record: `geol-16-fall-2026/docs/lesson_plans/records/class_04_taught_2026_09_14.md`.

## What Wednesday needs, in order

1. **Six rulings, then a deck.** `docs/lesson_plans/meetings/meeting_05_deck_plan.md` proposes a 75-minute meeting from three blocks: the repeat (slides 23 to 29 and 33 plus Key terms Class 4, on the proposed reading of "from 23 on"), the ten-slide magnetics seed, and the meeting's own ridge content from `Class13_TheMOR/Geo16Class13_MOR.pptx`, which has not been read. Data Lab 1.3 is promised in the room on the pasted `page_mtg05`. They do not fit; the largest ruling is whether magnetics moves to meeting 6 on Sep 23.
2. **The posting decision on `class_04_slides.pdf`.** It is exported and sits in the Meeting 04 folder, **not** in the public `Geol16_lectureSlidesF2026` folder. `meeting_04_sources.md` does not exist, so the licence gate cannot run, and slides 14 to 22, 24 to 28 and 33 are Class11 copies; slide 21 credits National Geographic 1968. Post as is, post without the copies, or write the sheet first. Dragging the file into the public folder publishes it.
3. **The Daily Inquiry sheet for meeting 5**, once ruling 4 in the plan sets the box count. On the iMac this is a WeasyPrint build and works.
4. **Announcements SmartArt** by hand in PowerPoint, six squares proposed in the plan. Square 6 carries the two dates students need this week: Data Lab 1.3 quiz due Sun Sep 20, no class Mon Sep 21.

`PUNCHLIST.md` rows 23 to 27 are today's additions; rows 7, 8, 11, 12 and 17 from Sunday were not reported on and may still be open.

## Two traps found today, both in the record

- **A slide can look blank to python-pptx and not be.** Meeting 4 slide 33 carries its hand-drawn cross-section as a picture fill on the placeholder, with no picture shape. The first posting builder dropped it as blank; the render caught it. `check_deck_postable.py` has the same blind spot (row 26). Render before trusting any "empty" slide.
- **PowerPoint AppleScript works on the MacBook and not on the iMac.** The PDF export ran from a session here. The iMac refused the same call on 2026-09-13 with -10003 until PowerPoint automation is allowed under Privacy and Security. Machine note added to `handoffs/README.md`.

## GEOL 333/714, untouched today

Nothing changed since the 2026-09-13 iMac session. The before-Wednesday list from `macbook_primer_2026_09_13.md` still stands: re-paste `page_wk3` in 714 and paste it in 333, create the Lin discussion thread, rename the Checkpoint 2 topic to Oct 21, and hand-verify `HW1_stairwell.ipynb`. `test_public_notebooks_are_not_stale` is red by design until that notebook publishes.
