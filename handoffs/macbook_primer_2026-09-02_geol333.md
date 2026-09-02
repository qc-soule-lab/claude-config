*AI-generated draft (Claude, Anthropic), for review. Written on the iMac just past midnight into 2026-09-02, after the shells went live for the first meeting.*

# Handoff to the MacBook, 2026-09-02

**Both courses meet today, Wed Sep 2**: GEOL 16 meeting 2 in the morning (separate repo,
untouched tonight), GEOL 333/714 meeting 1 at 4:35 PM in SB E227.

## State: the shells are done and match the repo

The whole 2026-09-01 cycle is closed. The nine-agent PM audit ran, its shell-facing slice was
ruled and applied on the iMac (`records/rulings_2026_09_01_pm.md`), the MacBook landed the
runsheet items and four notebooks, and the iMac finished the night: `bring_list.pdf` rebuilt,
the Block 9 SAY given the gravity round's Oct 14 sitting, all **sixteen pastes plus both
announcement fixes confirmed in** (`shell_change_log.md` @ `bff25ff`). The JP1 rubric PDF is
live and hash-verified. 86 tests, duplication ratchet 0 new.

**Pull first.** iMac commits after the MacBook's `97a6657`: `d6d44aa` (SAY fix + pack + reading
copy, now tracked at `outputs/handouts/runsheet.pdf`) and `bff25ff` (change log).

## The one dated obligation: the paper list, Thursday Sep 3

Tonight's Block 9 pitch tells the room the curated JP1 paper list posts **Thursday, September
3** on the Journal Presentation 1 page. That is now a promise made in class. It must clear
citation verification, post as a Brightspace page, and the JP1 page then takes one re-paste
(TBD 5 in the Wk 1 runsheet). The re-paste HTML build is iMac work; the citation verification
can happen anywhere.

Also owed before class today, per the Wk 1 pre-class checklist: compute the alphabetical round
split from the final roster and post the **named round assignments** to the JP1 paper selection
thread (instructor, in the shell).

## Open queue, none blocking today

1. **HW2_profile (7 items) and HW5_refraction (9)** through the expressiveness pass —
   MacBook-safe, markdown only. HW2 is not in the public repo (no republish); HW5 still carries
   the old Colab-deletes banner, the last copy that disagrees.
2. **Two minor handout/rubric trims** from the expressiveness report (§9, §10): the collection
   sheet's "Missed class? Email me." and the Copilot grading prompt's "need your eyes" — both
   sources editable anywhere; the collection-sheet PDF rebuild is the Chrome pipeline (works on
   the MacBook), and its Dropbox copy then needs the overwrite-in-place delivery.
3. **The syllabus re-delivery bundle** (take together, iMac, WeasyPrint): the "AI policy below"
   pointer, the Wk-5-only JP1 round language, the Oct 14 schedule row, one borderline sentence.
4. **The 333 Module 0 URL**: the 333 TOC anchors are `javascript:void(0)`; capture the id via
   right-click > Inspect (`ModuleCO-<digits>`), then the map entry + rebuild are iMac work.
   Four plain-text mentions, cosmetic.
5. **Paper-policy scope on the October pages** (wk7–wk13 "ask for a printed copy", spare cards,
   scaffold and one-pager delivery routes) — needs an instructor ruling on whether the 08-29
   ruling is course-wide.
6. **test_missing_links skip on map-less machines** — proposed, un-ruled. The MacBook suite is
   red by default until then (6 failed there: 4 WeasyPrint + 2 map).
7. **DRIVE-requires-SAY in `weekly_runsheet_template.md`** — Claude's promotion, still un-ruled.
8. **After Sep 2, not before** (instructor ruling): fix the MacBook WeasyPrint stack via
   Homebrew.

## After class today

The record-of-class-as-taught pattern from GEOL 16 applies: what was reached, what dropped, the
catalyst timing question from the walkthrough state (Block 1 Beat 1 timing unstated; whether
that catalyst is graded is undecided), and whether the in-class CSV matched the still-open
schema decision (deadline: the Sep 9 meeting).

## Repo state, all pushed

- `class_dev/geol-333-fall-2026` @ `restructure-rebalance-2026-06-21` `bff25ff` **PUSHED**
- `class_dev/geol-333-714` @ `main` `54c4d64` **PUSHED**
- `claude-config` @ `main` **PUSHED** (this file's commit is the tip)
