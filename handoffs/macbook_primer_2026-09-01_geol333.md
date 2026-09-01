*AI-generated draft (Claude, Anthropic), for review. Written on the iMac, midday 2026-09-01, at the point the runsheet walk was paused.*

# Handoff to the MacBook, 2026-09-01 midday

**Both courses meet tomorrow, Wed Sep 2.** GEOL 16 meeting 2 in the morning, GEOL 333/714 meeting 1 at 4:35 PM.

## Resume point

**GEOL 333 Wk 1 runsheet walk, Block 4 Beat 3.** He is reading the large-type PDF top to bottom, giving comments, and we apply them in batches. Blocks 1, 2, 3 are walked and Block 4 is walked through Beat 2.

Build and open the reading copy with a **fresh versioned filename** every time. Reusing a name leaves Preview showing the stale window and he correctly reports the edit as missing:

```
uv run scripts/build_handout_pdfs.py --md docs/lesson_plans/week_01_introduction/runsheet.md \
  --large-type --out-dir <scratchpad>
```

Nothing is queued. Everything he asked for this morning is applied, committed and pushed.

## What changed on the runsheet this morning

- **Block 1 Beat 1 opens differently.** Welcome, his name, then a catalyst question, "What is geophysics?", before anything administrative. The one-line course description is gone. Biography stays in Beat 2.
- **Beat 1's timing is now unstated** and needs his read. It was 1.5 min for five sentences of talk; a catalyst with answers taken is not that, and the clock policy says not to invent a number.
- **Open under that catalyst:** graded Daily Inquiry catalyst, or ungraded opener? Block 8 owns tonight's graded catalyst and the sheet has not been explained at 4:35, so ungraded is the smaller change.
- **SAY blocks are now a standard:** one main point at the top level, elaborations bulleted beneath, second level when a sub-point explains another sub-point. Applied to three blocks in Block 4 Beat 1. **Recorded in `docs/standards/weekly_runsheet_template.md`** so the thirteen unwalked weeks inherit it.
- **PAIR FIRST is renamed CATALYST QUESTION**, and CATALYST is a defined verb in the template legend. It may call for a drawing, and a labelled sketch is a full answer.
- **Block 4 Beat 2 gained the seven-row assumption table** as an instructor note.

## How he works, and the two rules that were learned the hard way

- **When he points at a line in a document, fix it.** Do not queue it. He had to repeat himself twice on 2026-08-30 because directives were logged instead of applied. **The exception is when he says he is reading top to bottom and will give comments to record** — then queue, and hold until he says apply. He said that this morning and it worked.
- **AI-drafted prose that carries voice gets deleted.** A syllabus section went through four rounds of him cutting sentences before he ruled the whole thing out. Flat register, no fragments for effect, no invented warmth.
- **Verify a Dropbox delivery by fetching the share URL and hashing the bytes.** A local copy proves nothing: one write was silently reverted by Dropbox, and one delivery captured a PDF built between two edits.
- **Render and look at figures.** `sips -s format png` then read the PNG. That caught three defects a text check passed.

## GEOL 333: what is owed

1. **The graduate advisor sent syllabus critique, and it gates the shell update.** Top of `PUNCHLIST.md`. Not in the repo yet. Sequence is written there: critique into `docs/syllabus/` first, rebuild both PDFs, deliver to **both** Dropbox paths and verify by fetching, rebuild both HTML sets, then one paste sitting. Both shells already owe a full re-paste since 2026-08-17.
2. **`rubric_hw2.pdf` reaches no student** and HW2 is due Sep 30.
3. **`depth_rule_problem_set.pdf` carries an instructor-facing banner** and is already named to students on `page_wk4:23` and `page_wk5:28`. It leaks the moment its placeholder token becomes a real URL. Needs his sign-off to strip.
4. Three `g = GM/R²` overclaims at `runsheet.md:17`, `:380`, `:633`.
5. The scribe format reaches Wk 1 Block 2 only; Blocks 4 and 5 are board-builds with him still holding the marker.
6. **Hold the Week 9/10 split** (Wk 9 runsheet is dated for Wk 10, no `week_10_*` dir) until the Magnetics and Seismic shape is decided under the coverage policy.

## GEOL 16: shipped today, and what is left

Shipped: `class_01_slides.pdf` posted to the shared Dropbox folder and verified from outside; `lecture_slides` page as topic **43341469**, replacing the bare Link 43341447; `daily_inquiry_page` as topic **43341510**, first item in the Exit slips module (`ModuleCO-42764445`); `syllabus_page` re-pasted. All three Dropbox links in that shell now carry `target="_blank"`, because **Dropbox sends `x-frame-options: SAMEORIGIN`** and D2L frames content topics. That fix had never reached GEOL 16. The catalyst sheet reached no live page until today, through meeting 1.

The announcement draft for the slides plus the meeting 2 reading is built at `docs/brightspace/announcement_class01_slides.html` and he decided **not** to post it.

Left: delete the retired Link topic 43341447 if still present; slide 3 needs the St Helens source and slide 5 needs who took the portrait, the last two rows before the deck passes `check_deck_postable.py`; the Lisbon carry-forward decision for meeting 2, which settles whether `EX 02` can keep `tsunami` and `seismic building code`.

Two build-sheet defects worth fixing before the next survey: `python_skills_survey.md` specifies no **Reports Setup**, which is the only way to see an anonymous survey's results, and its "D2L survey invitations, per-user pre-authorized links" delivery may describe a feature Brightspace Surveys does not have. Zero responses is consistent with nothing ever having been sent. Beat 4 already tells him to skip the line if the count is thin, so it costs one sentence.

## Repo state

All three pushed and clean except one untracked file:

- `class_dev/geol-333-fall-2026` @ `restructure-rebalance-2026-06-21` `b523eee` **PUSHED**
- `class_dev/geol-16-fall-2026` @ `main` `f9e30b9` **PUSHED**. One untracked file, `Prof Soule - GEO 333 and 714.docx`, a 333 document sitting in the GEOL 16 repo.
- `claude-config` @ `main` **PUSHED** (this file makes it dirty until committed)

Still open from the last handoff, neither touched: `meeting_dev/OOIFB_May2026_Plan` has no upstream tracking branch and will not pull; `forms_dev/qc_forms` has an uncommitted edit to a payment-request PDF.
