*AI-generated draft (Claude, Anthropic), for review. Written on the MacBook, late afternoon 2026-09-01, at wrap-up. Repo facts are read from the repos; rulings are the instructor's, recorded as given.*

# Handoff to the iMac, 2026-09-01 afternoon

**Both courses meet tomorrow, Wed Sep 2.** GEOL 16 meeting 2 in the morning, GEOL 333/714 meeting 1 at 4:35 PM.

The plan for the rest of today, as stated on the MacBook: finish the punch list, have Fable run an audit, then update the shell, hopefully for the last time.

## Do this first, in this order

1. **Check that `scripts/brightspace_pages_333.json` exists here.** It has never existed on the MacBook. If it is missing here too, the 333 shell has no buildable HTML set and half of today's rebuild cannot happen. Find out before planning the sitting, not during it.
2. **Rebuild the Brightspace HTML.** It could not be built correctly on the MacBook (see below). `uv run scripts/build_brightspace_html.py` for 714, and `--course 333` for the 333 set, which writes to `docs/brightspace/html_333/`.
3. **Build both syllabus PDFs.** They are still the Aug 31 build and do not contain today's changes. WeasyPrint is broken on the MacBook, so this could not be done there.
4. **Deliver both PDFs to both Dropbox paths and verify by fetching the share URLs and hashing the bytes.** A local copy proves nothing.
5. **Rebuild `outputs/instructor_packs/week_01/timing_card.pdf`.** It quotes all seven Wk 1 KEY lines verbatim and every one of them changed today, so the card on the podium disagrees with the runsheet.
6. Then the Fable audit, then the shell sitting.

## The one defect that matters, and the guard now on it

**`build_brightspace_html.py` on the MacBook produced HTML with 264 of its 336 internal links stripped.** The set went 336 links to 72. `datasets.html` alone lost its Week 2 and HW2 links.

**The cause is not a code bug.** The builder resolves cross-page names through `scripts/brightspace_pages.json` (714) and `scripts/brightspace_pages_333.json` (333). Both are gitignored, deliberately, because they hold live Brightspace topic URLs, so they never travel with the repo. The MacBook had a June-30 stub whose every value was an empty string, and the 333 map not at all. The builder's own comment says resolution "silently degrades to plain text" when a key is missing.

**Why it was nearly missed.** The output looks correct. The pages paste fine. Nothing exits non-zero. The only signal was a hundred routine-looking `page: name (714)` report lines scrolling past the `Wrote ...` messages. It was caught by diffing against the committed set, not by anything the build said.

**A preflight now refuses to build** when a map is missing or when more than half its keys have no URL, with `--force` to override. Six tests cover it. Commit `7134aaa`. On this machine the build should pass the preflight silently, because this is where the populated map lives and where the committed 336-link set was made. If it refuses here, stop and find out why before pasting anything.

The bad set was reverted and never committed. `docs/brightspace/html/` in git is the good one.

## The five rulings from this afternoon

Full text in `PUNCHLIST.md` under **DECISIONS, 2026-09-01**. In short:

1. HTML regression: diagnose on the MacBook, rebuild here. Paste nothing built on the MacBook.
2. WeasyPrint on the MacBook: fix after Sep 2, not during class week.
3. **Syllabi ship today without waiting on the graduate advisor.** The one-sitting rule is deliberately set aside: students holding a current syllabus tomorrow outranks avoiding a second delivery.
4. **Fable owns the pre-shell-update audit** and decides per stage whether to deploy Opus. Full and inclusive. It starts by confirming the shell pages are correctly mapped for this update and ends with an evaluation of the Wk 1 runsheet carrying suggestions and clarifications. It also audits the prose: jargon, AI-introduced personality, and "load-bearing" tells that read as AI slop rather than as the instructor. One known instance to seed that pass lives in `handoffs/README.md` itself, in the line about the PUSHED/LOCAL field.
5. Handoff is a full row plus this primer.

## What shipped today

**Wk 1 runsheet, Block 4.** Beats 2, 3 and 4 merged into one nine-minute beat that builds all seven assumption rows in three passes. Beat 1 gained a four-question **drop sequence** that makes the room derive that g is an acceleration and not a force, asked before Burger's derivation so the derivation confirms it. That sequence is the warrant for the gal being a unit of acceleration in Block 5 and for the pendulum measuring g and not the bob.

**All seven KEY lines** became goal lists, "Students leave able to:", with non-goal qualifiers moved to an italic note. **Every DRIVE-only beat gained a SAY.** Both changes are recorded as standards in `docs/standards/weekly_runsheet_template.md` so the thirteen unwalked weeks inherit them. The DRIVE-requires-SAY promotion was Claude's call, not the instructor's instruction, and is still un-ruled.

**Block 7 moved to numpy and is now walked rather than typed.** New `notebooks/lecture_01_onramp.ipynb`, published to the public student repo as `596bce2` and linked from `page_wk1.md`. It opens with a troubleshooting section. It works on two lists, five attempts at timing one swing against five attempts at timing five swings divided by five, and the single-swing list runs about five times wider. Collecting those lists is a §6 conditional that runs only if Block 5 Beat 5 is reached by 5:50; the notebook ships with realistic defaults so the block is identical when it is skipped. `np.std` carries `ddof=1` so the spread matches the pandas default HW0 relies on. **The homework protocol is unchanged**: students still time ten swings and divide by ten.

**Block 5 Beat 3 swaps the metal bob for the wooden one**, eyeball only. Same diameter, confirmed by the instructor, so the string mark already holds. The measured version is queued for Wk 2 with a note that the honest claim is a failure to detect a difference, not a measurement of equality.

**Both syllabi.** Finals week now carries the number 15, which is the specific thing the syllabus has been sent back for before. Boilerplate aligned to the QC graduate Syllabus Template (Spring 2026): Reasonable Accommodations replaces the old text with the SPSV wording, the official academic-dishonesty sentence opens Academic Integrity above the existing paragraph, and Wellness, Use of Student Work, Course Evaluations, Tutoring, Technical Support and a grading scale table were added. About 470 words, taking 714 from 9 pages to roughly 10 and 333 from 8 to roughly 9.

**Two deliberate deviations to defend if questioned.** An F row was added below 60 because the official table stops at D, and a syllabus defining no failing grade is worse than a table differing by one row. Both help desk addresses were kept, the template's `Support@qc.cuny.edu` and the existing OCT `helpdesk@qc.cuny.edu`, because they may be different desks; if they are the same, one is wrong.

**WU was left alone.** It already states the grade is non-punitive, and the template the advisor pointed at contains no WU language at all. That item is closed.

## Still open

- **Two questions are with the graduate advisor**: whether the template's `[suggested text]` sections are required for approval, and whether GEOL 333, an undergraduate course, should carry graduate boilerplate. If either comes back no, the syllabi change again and the PDFs and Dropbox deliveries move a second time. That was accepted knowingly under ruling 3.
- **`rubric_hw2.pdf` reaches no student** and HW2 is due Sep 30.
- **`depth_rule_problem_set.pdf` carries an instructor-facing banner** and is already named to students on the Wk 4 and Wk 5 pages. It leaks when its placeholder becomes a real URL. Needs sign-off to strip.
- **The Wk 1 pre-stage board sketch renders Panels A, C and D but not B.** The `<polygon>`, `<rect>` and `<line>` shapes in Panel B do not draw. Two traps were already found and fixed: a blank line inside an `<svg>` block ends the markdown HTML block and everything after it renders as prose with tags stripped, and `fill="#000"` text did not render while `#777` and `#333` did.
- **The instructor's own words are still owed** for the last bullet of Block 1 Beat 3, the one that binds him rather than them.
- **Wk 1 pre-class, still open**: the JP1 curated paper list and the alphabetical roster split for the rounds, the pendulum apparatus, the Python skills survey numbers, the catalyst half-sheets, and the SB E227 room check (machine count, whether they need a QC login, which browser).
- **GEOL 16 meeting 2 tomorrow morning, untouched today**: delete the retired Link topic 43341447 if still present, the St Helens source on slide 3, who took the portrait on slide 5, and the Lisbon carry-forward decision that settles whether `EX 02` keeps `tsunami` and `seismic building code`.

## Repo state, all pushed and clean

- `class_dev/geol-333-fall-2026` @ `restructure-rebalance-2026-06-21` `7134aaa` **PUSHED**
- `class_dev/geol-333-714` @ `main` `596bce2` **PUSHED** (public student repo; carries the new notebook)
- `class_dev/geol-16-fall-2026` @ `main` `f9e30b9` **PUSHED**, untouched today
- `claude-config` @ `main` **PUSHED** (this file makes it dirty until committed)

Today's commits in the course repo: `992f6d7` numpy rewire and walkthrough notebook, `bdb7bbe` syllabus boilerplate and the Wk 1 link, `4ef4b61` the five rulings, `7134aaa` the page-map guard.

`uv run pytest` reports `4 failed, 59 passed, 1 skipped` on the MacBook. All four failures are the WeasyPrint library gap and are identical on clean HEAD. Expect them to pass here.

Still open from previous handoffs, neither touched: `meeting_dev/OOIFB_May2026_Plan` has no upstream tracking branch and will not pull; `forms_dev/qc_forms` has an uncommitted edit to a payment-request PDF. The `Prof Soule - GEO 333 and 714.docx` sitting untracked in the GEOL 16 repo on this machine has still not been moved.
