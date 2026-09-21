*AI-generated draft (Claude, Anthropic), for review. Session plan written 2026-09-20 at his instruction, immediately before a context clear. All file paths and commit states are verified, not recalled.*

# Plan for the next sitting: GEOL 714 first, then GEOL 16

**His instruction, 2026-09-20, verbatim in substance:** make the plan, update
memory, push, then clear context. And: *"most of all we need to get ourselves
moved on to the work that Geol714 needs."*

So this file is ordered by his priority, not by deadline. Where a GEOL 16 item
has a harder clock than a 714 item, that is said in the row rather than used to
reorder the list.

## The clock

| Date | What lands |
|---|---|
| **Wed Sep 23** | Week 4 meets (333/714). HW1 due. GEOL 16 meeting 6 meets, 10:45-12:00, PH 115 |
| **Thu Sep 24** | CLR Checkpoint 1 backstop date |
| **Sun Sep 30** | Lin reading due. JP1 peer evaluation needed before this |
| **Sun Oct 11** | HW2b due, not started |
| **Wed Oct 14** | Midterm 1 |

Mon Sep 21 has no GEOL 16 class. The next sitting has **two teaching days'
notice** on everything marked Sep 23.

## A. GEOL 714, his stated priority

**A1. The Week 4 runsheet rebuild, before Sep 23.** Named as next in the
2026-09-18 handoff row and still open. Week 4 inherits Burger 6.2 whole plus the
Lin framing, because Week 3 stopped after 6.1.

**A2. The Lin methods discussion thread, 714-fenced, before Wed Sep 23.** Prompt
is drafted at `docs/brightspace/discussion_lin_methods.md`. **It has a
dependency that is not satisfied:** `week_04.../runsheet.md:56` says the Lin
paragraph must be on the Week 4 page before section 9 runs, and this prompt
points at that paragraph. So A1 and A2 are one job, not two. Its grading is
unruled.

**A3. CLR Checkpoint 1, backstop Thu Sep 24.** Three things, all his hands in
the browser: paste `assignment_clr` and `finding_papers` so the spoken launch
has pages to point at; rename the Brightspace Checkpoint 2 topic, which is still
titled "due Wed Oct 28" although the date moved to Oct 21. Two sentences on the
assignment page encode packet decisions 2 and 3, each still unruled and each
changeable by editing one sentence. Packet decisions 4 and 5 are unruled and
unbuilt.

**A4. Sixteen 714 pages carry a stale CLR assignment link.** The map is
repointed to the real content topic `43668812` and 21 built pages carry the
correction; the live shell still carries the old link on all of them. The old
link is not broken, it lands on the CLR forum, so this is a batch job rather
than an emergency.

**A5. HW2b, not started, due Sun Oct 11.** Twelve questions, none ruled. Needs
its own rubric, notebook, assignment doc, paste HTML and page-map entries. The
largest single piece of work outstanding in either course.

**A6. HW0 grading.** Named as next on 2026-09-18 and still open.

**A7. P2 is still unruled:** whether the objection is about the grade or about
the exam. 714's 50/25/25 weights are in its delivered syllabus; 333's 34/33/33
are not. A plain-language explainer exists at
`records/decision_packets_2026_09_12/p2_illustration_weight_explainer.md`.

## B. GEOL 16, his five items

Recorded in full at the top of `geol-16-fall-2026/PUNCHLIST.md` under **HIS
LIST, 2026-09-20**. Summarized here only so this file stands alone.

1. **Grade Exit Slip 5.** Blocked until Wed Sep 23: the slip ran Sep 16 and
   **names were not captured**, so identifiers cannot be matched to students
   until he is in the room. Everything else transfers from Class 4 unchanged.
2. **Design the Meeting 6 lesson, Wed Sep 23.** Submarine volcanism, inheriting
   25 carried slides (22 to 36 of the Class 5 source) before its own content
   exists. Slide 36 is a picture fill and reads as blank to a shape walk.
3. **Build a Meeting 6 exit slip, Wed Sep 23.** Nothing drafted. Class 5's slip
   is the template, but its misconception catalog M1-M9 and feedback bank
   F1-F19 are about layering and heat transfer and do not transfer to
   volcanism.
4. **Fix the Data Lab.** See section C.
5. **Vet the remaining assignments.** See section C.

## C. What happened to Data Lab 3.2, because it sets up item 5

Data Lab 3.2 went live as an eight-item quiz. **Two of the eight were not
answerable from the map they asked about**, and the one sentence telling
students to tick "Show Earthquakes Epicenters" was dropped by
`build_quiz_package.py`, which discards prose before the first question. A
student who opened the lab saw a blank relief map. Four attempts came in and a
complaint arrived 2026-09-20.

`data_lab_3_2_quiz_v02.md` is drafted, committed and tested: six items, two
objectives, 100 points, with an answer key whose every number regenerates from
`scripts/data_lab_3_2_key_stats.py` against the lab's own catalogue. Verified
2026-09-20, all figures reproduce exactly.

**Ruled 2026-09-20: the four existing attempts keep full credit.** They do not
retake; the rest of the class takes v02. Recorded inside v02.

**Seven build steps remain and most are in the browser:**

1. His review of v02, which it asks for explicitly.
2. Import as a **new** topic. Topic `43654971` holds four attempts, and editing
   a D2L quiz that has attempts risks that submitted work. It stays hidden and
   intact as the record of what was asked.
3. Paste the orientation block into the D2L Description field by hand. The
   builder will not carry it.
4. Grade item out of 100, one attempt, no time limit, Assignments category.
5. A due date. v02 deliberately leaves it unset.
6. `page_mtg04` still points at `43654971` and still says due Wed Sep 16 at
   10:45 AM.
7. Enter the four held-harmless students manually at full credit once the new
   grade item exists.

`data_lab_3_2_assignment.md`, which described a dropbox upload and contradicted
the live page, is marked **SUPERSEDED** rather than deleted, because it carries
the 2026-09-13 licence work and the original text of the two bad questions.

**Why item 5 exists.** Data Lab 3.2 was found broken only because someone worked
it against the live map. Nothing establishes that Data Lab 1.3, Data Lab 2, the
GeoMapApp lab or the three Problem Sets have had that treatment. **No assignment
in GEOL 16 has been checked by doing it the way a student would.**

## D. Two things waiting on his word, both cheap

**D1. The glossary disclosure line.** The glossary is built, tested and ready to
push to topic `43653717`. All 47 entries now carry a verified link, including
the six Class 5 terms added 2026-09-20 (mid-ocean ridge, pillow basalt, sheeted
dikes, gabbro, basalt, bathymetry). The only thing holding a clean push is the
disclosure line at the top, which still describes the glossary as Module 1 mined
from the first three decks and is two meetings behind. It is approved text, so
it is his to change. Proposed replacement:

> *AI-generated draft (Claude, Anthropic), for review. GEOL 16 glossary, Modules 1 and 2 as taught. Terms are the words marked in yellow on the posted class decks. Definitions are written for this course and are not taken from any textbook. Every entry links to a public page, each verified on 2026-09-20; each is named with its source.*

**D2. Whether his 2026-09-20 linking ruling goes in the governance log.** D21
requires his approval for governance log updates, so it was not added. The
ruling is recorded in the glossary's instructor note.

## E. One correction made on 2026-09-20, worth knowing

The glossary note had cited **"333 ruling 59"** as authority for leaving nine
entries without links, on the reasoning that a link landing on a hub is worse
than no link. **Ruling 59 does not say that.** It retired the assigned OpenIntro
reading and told the glossary to link content when needed. The hub sentence was
the drafter's justification for delinking sixteen citations that all resolved to
one OpenIntro hub page, and it was generalized into GEOL 16 as a standing rule
he never made. He ruled the opposite on 2026-09-20: **where possible, entries
link to rich, vetted content.** The note now says so.

## F. Two link-checking traps, found while doing D1

Both would make a link checker lie, and both are now in the glossary's
instructor note.

- **`rwu.pressbooks.pub` returns 403 to any client that does not send browser
  headers** and 200 to one that does. A bare checker reports twelve false
  failures.
- **LibreTexts URLs contain literal parentheses**, as in
  `Physical_Geology_(Earle)`. They are balanced and valid in CommonMark, but a
  naive URL regex truncates them and reports a false 404.
