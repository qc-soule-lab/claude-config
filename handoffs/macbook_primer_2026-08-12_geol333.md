*AI-generated draft (Claude, Anthropic), for review. Machine-transfer primer written on the iMac 2026-08-12 (evening) for the MacBook's next GEOL 333/714 session. Paths use `~` (= `/Users/dax` on the MacBook).*

# MacBook primer — GEOL 333/714 pickup (2026-08-12)

## Read this first

The MacBook's local Claude memory predates two days of iMac work (2026-08-11 and 2026-08-12) on the 714 Brightspace shell. Do NOT trust it for course state. Sequence:

1. `cd ~/repos/class_dev/geol-333-fall-2026 && git pull --ff-only` (branch `restructure-rebalance-2026-06-21`; iMac pushed through the math-cards commit `d410ec2` + the checkpoint commit after it).
2. Read `PUNCHLIST.md` top block ("714 shell go-live" + "Week 1 completion punch list") — canonical state.
3. Read `docs/lesson_plans/shell_change_log.md` (rows dated 2026-08-11/12) for exactly what is live in the shell.
4. Reconcile the MacBook's memory to those two files; rewrite its stale GEOL 333 entries.

## State in one paragraph

714 shell go-live steps 1-7 are done; **activation is HELD until Weeks 1-2 are polished** (instructor decision). Week 1 is now SHELL-COMPLETE: description + Week 1 Guide pasted (wording pass, live links: math cards, anchor table, OpenIntro, HW0 Colab, EDDIE vignettes); HW0 dropbox fully built (instructions with late-policy line + rubric PDF link, honor-pledge step deleted course-wide, one file per submission, Turnitin off, no end date, grade item in Problem Sets & Labs); HW0 rubric hard-edited, approved, delivered (Dropbox `handouts/rubric_hw0.pdf`); math_reference_cards.pdf hard-edited (AI tells, stale Video-3A/async refs, week renumbering, Bridge→Sinkhole), 7 clickable links, all four banners approved, overwritten in place on Dropbox; welcome announcement posted ("Course developed using Anthropic tools." disclosure line, mailto link).

## Dax's working conventions (established these two sessions)

- Repo-first; Claude loads built HTML onto the clipboard (`pbcopy < docs/brightspace/html/<topic>.html`); Dax pastes via D2L Source Code view; every shell change gets a same-day `shell_change_log.md` row.
- Hard-edit standard for student-facing prose: flat register, no AI tells, no meta-paragraphs promising process, no internal codenames (LO cells, video numbers) in student documents.
- AI-use disclosure: stated bluntly once (syllabus + day one + the announcement line), never repeated per-assignment ("we do not bray this like an angry mule").
- Dax is a **Project EDDIE PI and co-author of its statistical vignettes** (memory: `user_project_eddie.md` on the iMac; save the same fact on the MacBook): no licensing barrier to adapting EDDIE materials; vignette links now live on Week 1-2 pages + the math cards.

## Open items, in priority order

1. **Math Reference Cards page paste** — pending confirm: EDDIE primer line added to the page source (commit `d410ec2`); the paste to Resources > Math Reference Cards may or may not have happened before the iMac session ended. Check the live page; re-paste if missing (rebuild: `--md docs/brightspace/math_cards.md --course 714`).
2. **Week 2 pass** (finishes Module 0 and releases the activation hold): Week 2 Guide wording pass (known: false "(collected on the course pendulum apparatus...)" provenance claim on the datasets bullet must go; VanderPlas + EDDIE links already in source), Week 2 description paste, deliver `pendulum_data_collection_sheet.pdf` to Dropbox `handouts/` root + Dax mints share link, HW1 dropbox build (`docs/brightspace/html/assignment_hw1.html` is ready: late policy in, PDF invite out; settings mirror HW0), `rubric_hw1` chain (hard edit → Dax review → approved banner → PDF → Dropbox → link → re-paste), `week_02_lsq.ipynb` re-cast (§11 TBD 2, from `notebooks/week_03_async.ipynb`).
3. **Week 1 runsheet touch-up** — analysis done, blocked on ONE instructor decision: donor for the new 12-min stats beat (mean/SD/SE on the Colab periods list, appended to Block 7). Claude's rec: trig warm-up 25 → 15. Also adds a 3-min JP1 sign-up beat to Block 9 (5 → 8). Runsheet still says JP1 sign-up starts Wk 2 (line 20) — stale vs the page's "sign-up tonight."
4. **JP1 curated paper list** — Dax verifies 7 flagged citations (framework: `docs/lesson_plans/journal_pres_1/framework.md`, slots 1-7) + fills slots 9 (USGS OFR/SIR basin survey) and 10 (JEEG microgravity). HARD DEADLINE: list must post before the Sep 2 Week 1 sign-up. Then: strip markers, render list PDF, Dropbox, link on Week 1 page.
5. **HW0 notebook republish** — public Colab copy predates June review edits. Blocked on the **pendulum kit** (United Scientific Pendulum Investigation Kit, ORDERED 2026-08-12). On arrival: verify 1.2 m length reach + station count → decide Q5 (real instructor-collected 5×5 run would honestly replace the synthetic sample; recompute rubric ranges + grading prompt + self-checks from real CSV) → republish.
6. Dataset URL blessing (`pendulum_sample.csv`, `stairwell.csv` ride public GitHub raw URLs; record decision in `assignment_calendar.md`).
7. Then: flip the course Active (go-live step 8) + log it (step 9).

## Deadlines

- **Sep 2 (first class)**: JP1 list posted; Module 0 Week 1 fully live (is, minus JP1 list).
- **Sep 10-30 at sea**: Wks 3-5 LIVE SYNCHRONOUS online from the ship (NOT async — old MacBook memory may still say async; correct it). Zoom links via Brightspace Announcement from the ship.
