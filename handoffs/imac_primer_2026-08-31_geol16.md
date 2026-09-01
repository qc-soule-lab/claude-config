*AI-generated draft (Claude, Anthropic), for review. Written at the end of the 2026-08-31 MacBook session, the day meeting 1 of GEOL 16 was taught.*

# Handoff to the iMac, 2026-08-31

Two courses are live this week. **GEOL 16 meeting 2 is Wed Sep 2. GEOL 333/714 also starts Wed Sep 2.**

## Resume point

**GEOL 16, meeting 2 prep, and the decision is which of meeting 1's slides 18 to 24 carry forward.** Everything else on the GEOL 16 list follows from that answer.

Nothing was mid-edit when this session ended. Both repos are pushed and clean.

## What happened today

Meeting 1 was taught and **the room reached slide 17**, "November 1, 1755, about 9:40 in the morning". Slides 18 to 24 were not delivered. The Tambora overflow at 25 to 28 was never in play.

Full record: `docs/lesson_plans/records/class_01_taught_2026_08_31.md`. Summary at the top of `PUNCHLIST.md`.

## The one decision that gates the rest

`EX 02` runs at the **close of meeting 2** and asks about Class 1. Two of its marked terms were never on screen: `tsunami` (slide 18) and `seismic building code` (slide 20). The slide 23 key-terms recap did not run either.

**Teaching 18 to 24 at the start of meeting 2 fixes this by itself**, since the slip does not run until the close. Not teaching them means cutting both terms from `EX 02`.

The cost is that meeting 2 already holds 35 slides, Data Lab 2 in class, and the slip, in 75 minutes. A middle path is to carry the Lisbon payoff (18 to 20) and the recap (23), and move 21, 22 and 24 to Brightspace.

Related and separate: **slide 24 carried the meeting 2 reading and was never announced in the room.** The same reading is already on the Brightspace Meeting 2 page (`docs/brightspace/module1_overview.md:24`). Verify that page is live, then decide about an announcement.

## Three deck defects, all diagnosed, none fixed

The decks live in Dropbox at `~/Queens College Dropbox/.../Geo016_F26/decks_fall2026/`, not in git, so they reach the iMac through Dropbox rather than the pull.

1. **The repair prompt has a root cause.** `[Content_Types].xml` in `geo16_f26_mtg01.pptx` declares `jpeg`, `jpg`, `png`, `rels` and `xml` but not `svg`, and two SVGs sit inside the SmartArt on slides 6 and 7. That invalidates the package. Everything else checked clean: no duplicate zip entries, no dangling rels, no malformed slide XML, correct SmartArt element order.

2. **A fix attempt produced a file PowerPoint will not open.** `geo16_f26_mtg01_v2026-08-31.pptx` adds the missing declaration by rewriting the zip, validates on every offline check, and is still rejected outright. Cause unknown. **Delete it rather than reuse it.** Note for whoever retries: `open` returns success even when PowerPoint refuses the file, so confirm by checking for a `~$` lock file beside the deck.

3. **Slides 25 to 27 are title-only shells**, and this one is a standing bug. `append_overflow_mtg01.py` appended scaffolds on 08-23; the four scripts that built the real Tambora slides on 08-24 to 26 all hardcode `DECK = .../geo16_f26_mtg02.pptx`. So the figures only ever landed in meeting 2, and the titles render black on black because the white background comes from the same script that never ran. **Every future overflow append repeats this** until the scripts take a deck argument.

Not urgent: Tambora is meeting 2's own material and `geo16_f26_mtg02.pptx` slides 5 to 10 are complete and valid.

**File states:** the original `geo16_f26_mtg01.pptx` is untouched and hash-verified. `geo16_f26_mtg01- repared.pptx` is PowerPoint's own repair, verified complete against the original at 28 slides with identical titles and shape counts and zero shapes removed, and **is the file meeting 1 was taught from**. The eight `.pre_*` snapshots in that folder are intact. A further backup was taken to the MacBook scratchpad, which is machine-local and temporary; nothing depends on it.

## GEOL 333/714, untouched today and starting Wed Sep 2

The 2026-08-30 iMac handoff still stands as written: `~/repos/class_dev/geol-333-fall-2026/docs/lesson_plans/records/handoff_macbook_2026_08_30.md`. Its resume point is the **Wk 1 runsheet walkthrough at Block 4 Beat 2**, and its owed list is unchanged. The top item is that **`rubric_hw2.pdf` reaches no student** and HW2 is due Sep 30. Second is that `depth_rule_problem_set.pdf` carries an instructor-facing banner and is already named to students on two week pages, held back only because those pages carry a placeholder token instead of a real share URL.

That handoff's delivery-verification rule is worth re-reading before shipping anything: fetch the share URL and hash the bytes, because a local file copy proves nothing and Dropbox has already reverted one write.

## Repo state

Pushed today from the MacBook:

- `class_dev/geol-16-fall-2026`: the teaching record and the PUNCHLIST section above it.
- `claude-config`: this file.

Everything else was pulled, not modified. Two loose ends found during that pull, neither touched:

- **`meeting_dev/OOIFB_May2026_Plan` will not pull.** Its `main` has no upstream tracking branch, and it holds untracked `.gitignore`, `.specify/`, `CLAUDE.md`, `PROJECT_CONTEXT.md` and `docs/`. Needs `git branch --set-upstream-to=origin/main main` and a decision on the untracked files.
- **`forms_dev/qc_forms` has an uncommitted edit** to `blank_forms/QCF-Payment-Request Microsoft Azure.pdf`.

## Also true, and unrelated to the deck

The offline backup of the St Helens video is **0 bytes on the MacBook**, in all four copies of `msh_1980.mp4`, dated Apr 2024, which is a Dropbox online-only placeholder. Meeting 1 streamed it instead. If the iMac has a materialized copy it is worth getting one onto the teaching machine before it is needed again.
