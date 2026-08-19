*AI-generated draft (Claude, Anthropic) — for review. All parameters and figures are derived from version-controlled scripts and data.*

# Machine handoff: iMac to MacBook, 2026-08-19

Written for whichever MacBook Dax picks up. Covers a long [iMac] session on
2026-08-18: an orchestrator-pattern trial, three expense filings, and GEOL 16
arc planning. Read the GEOL 16 section first; it holds the only work that is
decided but unwritten.

Everything below is pushed. `claude-config`, `expense_reports`, `qc_forms`, and
`geol-16-fall-2026` are all clean against origin/main as of this writing.

## Pull these before starting

```
git -C ~/repos/claude-config pull
git -C ~/repos/report_dev/expense_reports pull
git -C ~/repos/forms_dev/qc_forms pull
git -C ~/repos/class_dev/geol-16-fall-2026 pull
```

**`geol-333-fall-2026` is on branch `restructure-rebalance-2026-06-21`, not
main.** Clean, but do not assume main.

## GEOL 16: decided in conversation, NOT YET WRITTEN

This is the live workstream and the reason this primer exists. Dax approved a
plan and then switched machines before it was written to any file. Nothing below
is in the repo yet.

**A two-meeting historical opening**, replacing the single-meeting one. Framing
title: "Earthquakes, volcanoes and tsunamis: changing the world", echoing the
course title. Rationale in Dax's words: students should be hooked before he
sails, because meetings 1 to 3 are the only in-person meetings before the at-sea
window opens at meeting 4.

- **Meeting 1 (Mon Aug 31).** Course structure compressed to ~15 min.
  **Vesuvius**: Pliny's letters, the origin of "Plinian", three million people
  living there now. **Lisbon 1755**: earthquake then tsunami then fire; Pombal's
  parish survey as the first systematic seismological inquiry; the *gaiola
  pombalina* as the first seismic building code; Rousseau's reply to Voltaire on
  who built where. Close on the September promise. PG 1.1-1.3 unchanged.
- **Meeting 2 (Wed Sep 2).** **Tambora 1815** and the year without a summer,
  with the mechanism explicitly deferred. Then the turn into Earth structure and
  layers and the cabled observatory, which this meeting already held. Data Lab 2
  (graph reading) stays in week 1 per Dax's standing directive. PG 1.4-1.6, 9.1
  unchanged.
- **Meeting 3 untouched.** Heat engine, Data Lab 1, PG 9.2. This matters:
  meetings 2 and 3 are the prerequisites that make plate tectonics from a
  spreading center comprehensible, so the opening was designed to reframe that
  content rather than displace it.

**The three cases are planted early and harvested by meetings that already
exist.** No new meetings, no thirteenth objective.

| Case | Planted | Harvested |
|---|---|---|
| Vesuvius | 1 | 20, volcanic hazards on land, the populated-volcano problem |
| Lisbon | 1 | 17 tsunami; 22 hazard maps, codes, mitigation |
| Tambora | 2 | 24, forecasting two volcanoes, where the mechanism lands |

"Plinian" planted at meeting 1 also pays off at meeting 6 against objective 1
(course vocabulary).

**How this evolved, so nobody re-opens it.** Dax first asked for a standalone
lecture on volcanoes and climate. Claude found no objective and no meeting
covering climate anywhere, making it a genuine addition to a full 28-meeting
arc, and offered two placements: the async Dec 9 slot, or displacing meeting 25
(Wilson cycle). Dax proposed the historical-framing intro instead, which is
better: the course already **ends** on who bears the risk, so opening on
geohazards as agents of historical change gives a bookend; it needs no
thirteenth objective because it is framing rather than assessed content; and it
serves the Flexible Core E policy-and-public-concern outcome already claimed.
The Wilson cycle survives. **Consequence to remember: Dec 9 async therefore has
no asset yet.** That was the deferred option's quiet virtue and it is now gone.

**Four other list items, placements agreed, also unwritten:**

1. **Plate boundary activity** (identify boundaries, connect to seismicity and
   volcanism). Serves objectives 4 and 5, both already claimed, both assessed at
   Exam 1 on Oct 5. Placement is close to forced: the only pre-Exam-1 meetings
   carrying those objectives are 4, 5, 6, all inside the at-sea window, and
   meetings 4, 5, 6, 8 still need bandwidth-proof fallbacks. So build it as
   **meeting 4's Brightspace fallback, posted before he sails**. One build,
   two requirements. Auto-graded.
2. **Virtual Earthquake: dropped.** Already logged do-not-adopt in
   `resources_inventory.md`. Meeting 14 already reads "Epicenter P-S lab" and a
   local lab exists in Dropbox. SAGE has CC BY epicenter activities if a hosted
   one is wanted.
3. **Megaquake: The Hour That Shook Japan** (Darlow Smithson, Discovery, 2011,
   45 min, not NHK). To **meeting 16**, "Subduction and great earthquakes",
   which has an empty activity column and whose topic is literally the film's
   closing question about the Pacific Northwest. Assign as out-of-class viewing
   so the 75 minutes stay free, plus a five-question auto-graded quiz.
   **Blocking check: verify the Reel Truth Science YouTube posting is official.**
   If it is not, this becomes in-class only and 45 minutes come out of meeting
   16. Netflix carries it but a personal subscription does not license classroom
   screening.
4. **Lava Bombs: Truths Behind the Volcano** (GeoTenerife, 63 min, Tajogaite /
   La Palma 2021). To **meeting 20**, "Volcanic hazards on land", empty activity
   column. **Excerpt 20 to 25 minutes, not all 63.** Rent-or-buy only on Apple,
   Amazon, Google, so: in-class showing under the face-to-face exemption on one
   purchase by Dax. It **cannot** be assigned or posted, and therefore cannot
   serve the Dec 9 async meeting; requiring students to rent would reintroduce
   the paid barrier the whole revision exists to remove.

**Design constraints Dax stated for all of this:** zero-level class, so
engagement over rigor; be cautious about assigning too much work; build for easy
or automatic assessment in Brightspace; students who do not engage will fail, but
honest effort should be an easy grade. Everything above is completion-based or
auto-scored, needs no hand-grading, and lands inside the existing Assignments
30% and Daily Inquiry 30% buckets, so **weights do not change**.

## GEOL 16: what IS written and pushed (`9a05ecf`)

- `scripts/build_syllabus.py` + `tests/test_build_syllabus.py` + `syllabus.css`.
  The repo can now build its own syllabus PDF: `uv run python
  scripts/build_syllabus.py`. Strips the AI banner by default; `--keep-banner`
  for a review copy. `smarty` deliberately absent so `--` never becomes an em
  dash. WeasyPrint added to `pyproject.toml`; needs `brew install pango` on a
  fresh machine.
- Syllabus front matter and schedule now carry the **AGU absence**: away Dec
  3-13, Exam 2 in person and proctored Mon Dec 7, Wed Dec 9 asynchronous, back
  in person Dec 14.
- `resources_inventory.md`: SAGE verified **CC BY 4.0**; Virtual Earthquake
  logged do-not-adopt.

## GEOL 16 open items

- **Dec 9 Daily Inquiry.** It is 30% of the grade and defined as in-class
  catalyst questions and peer discussion plus an exit slip. An async meeting has
  no peer discussion, so Dec 9 currently has no stated path to that credit, and
  CUNY bars attendance as a grading criterion. Needs either a discussion-board
  substitute or a carve-out saying Dec 9's credit is the exit slip alone. Claude
  deliberately left the syllabus silent rather than inventing policy.
- **Dec 9 async asset** must be built before Dec 3, and the climate lecture is
  no longer available for it.
- **Five em dashes in the syllabus source** violate the repo's own prose
  standard: line 3 in the title, and four "no meeting" cells in the schedule
  table (lines 107, 111, 117, 131). Dax has not said how he wants them handled.
- **Two proctors needed on two different days**: GEOL 16 Exam 2 Mon Dec 7
  morning, and GEOL 333/714 Midterm 2 Wed Dec 9. That second one was already
  marked *(proctored)* in `term_lo_map.md`, which presumably meant by Dax; it
  now needs a third party.
- Unchanged from before: locate the Kelley recording; source Data Labs 1, 3,
  3.1, 3.2; verify Axial's state and the dive schedule; fallbacks for at-sea
  meetings 5, 6, 8 (4 is now the boundary activity); room; student hours.

## Expenses: WHOI submitted, two parked

Full detail is in the iMac's `expense_report_workflow` memory, which does not
travel. The load-bearing parts:

- **WHOI travel voucher SUBMITTED 2026-08-18**, day five of RF's five-day
  window. `OH_2026/08_12_WHOI_Visit/`, net **$763.04**. Nothing pending unless
  RF asks, and the answer is already written in `trip_justification.pdf`.
- **Reusable facts.** RF pegs POV mileage to **GSA, not IRS**; the GSA rate
  effective 2026-07-01 is **$0.760**. A $0.535 figure in secondary summaries of
  RF guidance is wrong, it is an IRS rate from 2017. The 75% first-and-last-day
  M&IE rule is RF's own, stated in RF-041 instruction (b). RF's per diem PDF is
  stale, its tables are FY2019; use the method, pull rates from gsa.gov by ZIP.
  Filing window is five days after trip completion.
- **Blank RF forms live in `~/repos/forms_dev/qc_forms/blank_forms/`, not
  Dropbox.** Every rf-041 copy in the Dropbox tree is a 0-byte Dropbox
  online-only placeholder. A stale memory line pointing at Dropbox
  `EmployeeInfo/Forms` cost most of an hour on 2026-08-18; that line is fixed on
  the iMac but the lesson is worth carrying.
- **Account `40L25-00-01` is Magma2Vents and it is an NSF award**, so a direct
  federal award: GSA ceilings are the benchmark. Do not infer otherwise from the
  `OverheadAccount` folder name, which is a filing convention. `90917-13-07` is
  the older Axial award. Do not pick an account from trip subject matter.
- **Pendulum kits, P&B request PARKED.** `OH_2026/08_06_pendulum/` (the
  duplicate `08_16_NexeraScientific/` was merged in and removed). Nexera order
  #1068, five United Scientific Pendulum Investigation Kits, $336.83. This is a
  funding **request**, not a claim: no account assigned, and Dax emailed an
  abbreviated note to **Greg O'Mullan** on 2026-08-18 with
  `pb_funding_request_pendulum.docx` held in reserve. If P&B says yes, fill
  `research_purchases_expense_template.xlsx` with the account they assign.
- **AGU26 abstract fee: receipts only, no paperwork** (Dax's call).
  `OH_2026/08_04_AGU_Abstract/`, invoice #2074310, $80.00. More AGU charges are
  coming: membership and registration are separate charges per the receipt.
  **`08_04_AGU_Abstract/student_abstract/` is closed to Claude**; Dax handles
  the student filing.
- **Two new tools** in `expense_reports` (`dd8dca6`, `3533da7`):
  `strike_rows.py` annotates a card statement whose rows span several filings;
  `verify_voucher.py` recomputes a written RF-041 from its own PDF fields. Both
  tested. Note both a strikethrough and a real PyMuPDF redaction are now
  precedent for the same two stray charges; **ask Dax which he wants** rather
  than picking.

## Orchestrator trial, running 2026-08-18 to 2026-08-25

`claude-config/docs/orchestrator_playbook.md` plus
`docs/delegation_log.csv`. Fable orchestrates and verifies, Sonnet implements,
and the orchestrator re-derives results from the data rather than reviewing the
report. **Log every delegation as it resolves**, including ones abandoned
because specifying them cost more than doing the work.

**The decision rule is LOCKED** (PI, 2026-08-18, `0dfff4f`, pre-committed before
any week-2 data). Continue the pattern as default practice if, over **at least
10 logged delegations**: zero defects `escaped_to_human`; every defect caught by
`orchestrator_verification` rather than luck or the implementer's own
assertions; and no more than 2 delegations `abandoned`. Any escaped defect means
reverting to hands-on for that task class pending a post-mortem logged in the
playbook. **The rule binds at n≥10, not at the calendar date**, so if fewer than
10 delegations accumulate by 2026-08-25 the window extends rather than being
judged on thin data.

**One correction to carry.** Dax's commit `aa772b1` fixed a real error of
Claude's: the server-side fallback target for a Fable 5 refusal is
`claude-opus-4-8`, not Opus 5, and that part of the edit is right. The
parenthetical claiming "Opus 5 does not exist" is not: **Claude Opus 5
(`claude-opus-5`) is a real model** and is what the iMac session was running on.
The reason 4.8 is correct there is that it is the documented fallback target for
Fable 5, not that Opus 5 is fictional. Flagged to Dax; the playbook line is
unchanged pending his call, so do not use that parenthetical to reject a
`claude-opus-5` model ID.

## One process note worth carrying

Two real defects this session were caught only by rendering an artifact and
looking at it, after the tool reported success: a memo built onto letterhead
landed on page 2 because the blank carried a stray hard page break, and a
statement annotation drew its explanatory note straight through the one line the
filing actually claimed. In both cases the script's own output said it had
worked. Render and look.
