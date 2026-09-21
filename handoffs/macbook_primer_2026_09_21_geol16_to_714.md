*AI-generated draft (Claude, Anthropic), for review. Machine-transfer primer written on the iMac 2026-09-21 at the end of a long GEOL 16 session, as he moves to the MacBook to work on GEOL 714.*

# MacBook primer, 2026-09-21: GEOL 16 is parked, GEOL 714 is next

## Pull first

```
cd ~/repos/class_dev/geol-16-fall-2026 && git pull
cd ~/repos/claude-config && git pull
cd ~/repos/class_dev/geol-333-fall-2026 && git pull
```

Both of the first two were pushed clean from the iMac: `geol-16-fall-2026` at `cd56391`,
`claude-config` at `811d54a`. Nothing is uncommitted on the iMac.

## What he is going there to do

**GEOL 714.** GEOL 16 is finished through Wednesday Sep 23 and needs nothing further from a
keyboard this week. Read `claude-config/handoffs/README.md` for the newest 714 rows before
proposing anything: the last 714 session was 2026-09-16 and its own detail note is named there.

## Three MacBook gotchas, checked rather than assumed

### 1. WeasyPrint is broken here, and five builders use it

Standing machine note, diagnosed 2026-09-01: WeasyPrint cannot load `libgobject-2.0-0`. In this
repo that breaks `build_opening_quiz.py`, `build_return_slips.py`, `build_mtg04_exit_slip.py`,
`build_catalyst_questions.py` and **`build_syllabus.py`**.

**The good news is that none of it blocks him.** The syllabus PDF was rebuilt on the iMac with the
Oct 7 exam date, 55 KB, and it is committed. So the outstanding Dropbox overwrite is a **file copy,
not a rebuild**:

```
cp ~/repos/class_dev/geol-16-fall-2026/docs/syllabus/syllabus_geol16_fall_2026.pdf <the Dropbox copy>
```

Overwrite in place so the share link survives, then send the chair the corrected copy.

**`build_catalyst_sheet.py` renders through headless Chrome, not WeasyPrint, so it works here.**

### 2. The quiz cartridges do not travel

`outputs/*.imscc` is gitignored, so `geol16_data_lab_3_2_quiz_v03.imscc` and
`geol16_geomapapp_lab.imscc` are not in the pull. Both rebuild from source in seconds:

```
uv run python scripts/build_quiz_package.py --quiz data_lab_3_2_quiz_v03.md --out outputs/geol16_data_lab_3_2_quiz_v03.imscc
```

Neither is needed again unless a quiz is re-imported. Data Lab 3.2 v03 is already imported and live.

### 3. Dropbox files may be placeholders

Wednesday's materials are in Dropbox, not git:

- `Meeting 06 - submarine volcanism/geo16_f26_mtg06.pptx`, the 33-slide deck
- `Meeting 06 - submarine volcanism/geol16_mtg06_catalyst_sheet.pdf`, 50 sheets

**Shell reads do not trigger a download.** `cat`, `head` and `cp` return 0 bytes instantly on a
placeholder and a copy of one is a 0-byte file with no error. `open <file>` does trigger it. So:
`stat -f%z` first, `open` anything reading 0, wait, re-check the size, then use it.

**If he teaches Wednesday from the MacBook, pin those two files before the meeting.**

## GEOL 16, where it actually stands

**Read the STATE block at the top of `geol-16-fall-2026/PUNCHLIST.md`.** In one paragraph:
Wednesday is covered. The deck is built and render-checked, EX 06 is posted as one native matching
question, the catalyst sheet is built with a name face and a coded work face, `page_mtg06` is
pasted with key terms and a glossary link, Data Lab 3.2 v03 is live and due Sep 28, the glossary is
at 58 entries, and the week 5 announcement is posted.

**What is left for him physically:** review the deck, and print the catalyst sheets **duplex on the
LONG edge, from Preview rather than Acrobat**.

### The correction that invalidates earlier reasoning

**"There is no such thing as completion grading. That is a misunderstanding."** Eight surfaces say
Daily Inquiry is graded on completion, including the syllabus and four live pages. **He has not
said what it IS graded on.** Every proposal made before that correction was built on the wrong
premise. Do not rewrite those surfaces and do not invent a new reading; ask him for one sentence.

### The two risks worth naming out loud

**Meeting 7 has no deck and is Mon Sep 28. Meeting 8 has no folder, no deck and no source deck and
is Wed Sep 30.** Both land before Exam 1 on Oct 7, which tests them. Neither is a MacBook problem,
but neither gets smaller by waiting.

## Outstanding pastes, if he ends up back in GEOL 16

`contact` · `start_here` · `syllabus_page` · `module1_overview` · `page_mtg09` · `page_mtg10` ·
`module2_overview` needs **re-pasting**, it was edited after he pasted it. Built HTML is in
`docs/brightspace/html/` and travels with the pull.

## Two findings from this session that cost time and should not be rediscovered

- **D2L's quiz player refuses third-party iframes.** He confirmed it by taking the quiz. Content
  pages render them fine, which is why the Ocean Data Lab map lives on `page_mtg04`. Do not retry.
- **D2L Preview discards attempts on exit**, so it cannot test whether a student can resume an
  unsubmitted quiz. Two resume tests failed under different paging settings and the harness was the
  likely cause, not the setting.
