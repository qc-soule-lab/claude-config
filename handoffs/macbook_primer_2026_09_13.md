*AI-generated draft (Claude, Anthropic), for review. Written on the iMac at the end of 2026-09-13 for a MacBook session over the following 24 hours. Repo states are read from the repos; the MacBook facts are from the Machine notes in `handoffs/README.md`.*

# MacBook primer, 2026-09-13 → 14

**Monday Sep 14 is GEOL 16 meeting 4, 10:45 in PH 115. Wednesday Sep 16 is GEOL 333/714 Week 3.**

## Read this before anything else: three things the MacBook does differently

**1. Dropbox files may be online-only and read as 0 bytes.** This bit on 2026-08-31, when `msh_1980.mp4` read as 0 bytes on the MacBook and 58 MB on the iMac. **Everything Monday needs is in Dropbox**: the deck, the printable sheet, the Class 3 recap. Before leaving the network, make these available offline:

- `Class Meetings 2026/Meeting 04 - plate tectonics/geo16_f26_mtg04.pptx` — the 34-slide deck taught Monday
- `Class Meetings 2026/Meeting 04 - plate tectonics/geol16_mtg04_exit_slip.pdf` — 50 sheets, 100 pages, to print
- `Class Meetings 2026/Meeting 04 - plate tectonics/geo16_f26_mtg05_magnetics_seed.pptx` — Wednesday's seed

**2. WeasyPrint cannot run on the MacBook** (no `libgobject-2.0-0`). Every PDF in the 333/714 repo and most in GEOL 16 is a WeasyPrint build. **So do not plan to rebuild a handout PDF there.** `build_catalyst_sheet.py` is the exception; it renders through headless Chrome. If a PDF needs rebuilding, it waits for the iMac.

**3. Terminal selection does not copy** (mouse reporting; diagnosed 2026-08-31). Ask for `pbcopy` rather than trying to select text out of the terminal.

## First five minutes on the MacBook, in order

**1. Pull four repos.** `geol-333-fall-2026` is on a **non-default branch**, so a plain pull will not get tonight's work:

```
cd ~/repos/class_dev/geol-16-fall-2026    && git pull          # main, ec781be
cd ~/repos/class_dev/geol-333-fall-2026   && git checkout restructure-rebalance-2026-06-21 && git pull
cd ~/repos/class_dev/geol-333-714         && git pull          # main, 1345f08
cd ~/repos/claude-config                  && git pull          # main
```

**2. Install the Brightspace page maps. Nothing that builds HTML works without them.** They are gitignored in both repos because they hold live shell topic URLs, so a clone does not have them. Copies are staged in Dropbox:

```
D=~/"Queens College Dropbox/Dax Soule/AllFiles/QueensCollege/QC_Classes/_shell_page_maps"
cp "$D/geol16_brightspace_pages.json"      ~/repos/class_dev/geol-16-fall-2026/scripts/brightspace_pages.json
cp "$D/geol714_brightspace_pages.json"     ~/repos/class_dev/geol-333-fall-2026/scripts/brightspace_pages.json
cp "$D/geol333_brightspace_pages_333.json" ~/repos/class_dev/geol-333-fall-2026/scripts/brightspace_pages_333.json
```

Both builders now refuse to run without one, so a missing map is an abort rather than a silent link strip. GEOL 16's guard was added tonight; 333 has had one since 2026-09-01, when a stub map cut its built set from 336 internal links to 72 with no failure signal.

**3. Check the tests.** GEOL 16 should be fully green (435). `geol-333-fall-2026` should be `1 failed, 207 passed`, and the one failure is `test_public_notebooks_are_not_stale` — that is the flag saying the HW1 notebook is waiting for its hand check, not a regression.

## Things that are NOT in git and where they are

| What | Where | Note |
|---|---|---|
| Brightspace page maps | Dropbox `QC_Classes/_shell_page_maps/` | Gitignored. See step 2. |
| GEOL 16 quiz packages (`.imscc`) | not tracked, iMac only | Rebuild instead: `uv run python scripts/build_quiz_package.py --quiz data_lab_3_2_quiz.md --out outputs/geol16_data_lab_3_2_quiz.imscc`. No WeasyPrint needed, so this works on the MacBook. |
| Decks and printable PDFs | Dropbox `Class Meetings 2026/` | **Pin offline before leaving the network.** |

## Where tonight's findings are written down

- `geol-333-fall-2026/docs/lesson_plans/records/punitive_register_sweep_2026_09_13.md` — every punitive-register finding with a proposed rewrite, and every points figure with its syllabus source or a note that it has none. **Copied into the GEOL 16 repo too**, because a third of the findings are GEOL 16's. Nothing student-facing was reworded on the strength of it.
- `geol-333-fall-2026/docs/lesson_plans/records/hw1_defect_repairs_2026_09_13.md` — what the HW1 vetting verified and changed, and the exact publish commands.
- `docs/lesson_plans/records/decision_packets_2026_09_12/p2_illustration_weight_explainer.md` — the plain-language explainer for the one ruling he said he did not yet understand.
- Both `PUNCHLIST.md` files carry a numbered index at the top, ranked by urgency, renumbered in reading order.

## What is already done and needs nothing

**GEOL 16 is ready for Monday.** Deck at 34 slides, ending on the closing block so the key terms, the sheet hand-in and "before we next meet" all run inside the meeting. Class 3 recap posted. Glossary pasted. Both data lab quizzes imported and linked. Five pages pasted. The Daily Inquiry sheet is built at two catalysts, matching the deck after the split.

**GEOL 333/714:** the Lin announcement posted to both shells, which makes Week 3 section 6B's "They have it now" true. `assignment_jp1` pasted in both shells, `assignment_clr` into the content topic he created, `finding_papers` into both. The corrected `relative_mgal` sign is live in the public student repo.

## The two things standing between tonight and Monday's room

1. **Print the Daily Inquiry sheet**, 50 copies, **duplex on the LONG edge**. **Print from Preview, not Acrobat.** Acrobat was mid-update tonight and threw "problem reading this document (11)" on every PDF, including one printed successfully last week. Nothing is wrong with the files.
2. **Post the GEOL 16 announcement.** It covers the Class 3 slides, the glossary, Data Lab 3.2 and Data Lab 1.3, and everything it names now exists in the shell. Built at `docs/brightspace/html/announcement_class03_slides_glossary_lab13.html`.

## Before Wednesday

- **`page_wk3` needs re-pasting in 714 and pasting in 333.** The Lin reading was lifted out of the 714 fence *after* the 714 copy was pasted, so the live 714 page is one edit behind and **333's copy has never been pasted and is the one that now carries the reading**.
- **Create the Lin discussion thread.** The announcement students just received tells them to post there, for both courses now. Prompt drafted at `docs/brightspace/discussion_lin_methods.md`.
- **Rename the Brightspace Checkpoint 2 topic** from "due Wed Oct 28" to Oct 21.
- **Check Data Lab 2's quiz description** carries the three-attempts rule. It was imported before any description existed, and the rule was removed from three pages tonight on the ruling that it belongs in the quiz description only. **That quiz is due Monday 10:45.**

## Two things a MacBook session can do well

**Hand-verify `HW1_stairwell.ipynb`** — no PDF build, no Dropbox dependency, and it is the gate on publishing. Three things changed in it: Part 4 reordered so the drift-corrected overlay draws after the fit, the grading check moved from the gradient to the ground-read closure, and **Q6.1 rewritten**. That rewrite is unconfirmed and is isolated in `11cae17`, so `git revert --no-edit 11cae17` undoes it alone. `test_public_notebooks_are_not_stale` fails by design until it publishes.

**Rule the open questions.** Each has its material written and needs no machine: the grade-versus-exam explainer, the AI-banner classification (which artifacts are student-facing), the punitive-register rewrites, and the seven Week 3 vetting-ledger items.

## A correction worth carrying

I told him the CLR's 5-point deduction was invented and not in the syllabus. **It is in the syllabus**, at `syllabus_geol714_fall_2026.md:175`, since the June 12 ratification. I read :141 and :179 and missed :175. He deleted a line partly on that claim. The register finding stood on its own and the rewrite is right; the provenance claim was wrong.

## Known-red test

`geol-333-fall-2026`: `test_publish_student_repo.py::test_public_notebooks_are_not_stale` fails on purpose. It is the flag saying the HW1 notebook is waiting for the hand check. Everything else is green in both repos.
