*AI-generated draft (Claude, Anthropic), for review. Computed from delegation_log.csv rows 1-55 as of 2026-08-29; every number is reproducible from that file.*

# Orchestrator trial retrospective

Source: `docs/delegation_log.csv`, 55 logged delegations (rows 9-63 of the file; the file's 56-row count as of 2026-08-28 night includes the header row). Cross-referenced against `docs/orchestrator_playbook.md` and `~/.claude/projects/-Users-daxsoule/memory/project_orchestrator_trial.md`.

## 1. Decision rule and whether n has reached threshold

The decision rule, as locked in `docs/orchestrator_playbook.md` (2026-08-18, before any week-2 data):

> Continue the pattern as default practice if, over ≥10 logged delegations:
> 1. **(a) zero defects `escaped_to_human`** — every defect was caught before reaching the PI or a shipped artifact;
> 2. **(b) every defect was caught by `orchestrator_verification`** — the independent verify layer, not luck or the implementer's own assertions;
> 3. **(c) ≤2 delegations `abandoned`** because specifying cost more than doing the work directly.
>
> Any escaped defect = revert to hands-on for that task class pending a post-mortem logged in this file. If fewer than 10 delegations accumulate by 2026-08-25, extend the window rather than judging on thin data, the rule binds at n≥10, not at the calendar date.

n = 55, which is ≥10. The rule binds.

## 2. Counts

**By implementer model** (outcome: clean / clean_with_correction / defect):

| model | n | clean | clean_with_correction | defect |
|---|---|---|---|---|
| sonnet-5 | 25 | 21 | 3 | 1 |
| opus-5 | 15 | 13 | 2 | 0 |
| fable-5 | 15 | 15 | 0 | 0 |

**By task class**:

| task class | n | clean | clean_with_correction | defect |
|---|---|---|---|---|
| mechanical | 36 | 34 | 2 | 0 |
| mixed | 9 | 7 | 1 | 1 |
| judgment | 10 | 8 | 2 | 0 |

(The log's own header comment defines `task_type` as mechanical/mixed/judgment_heavy and `outcome` as clean/defect/abandoned; the data as recorded uses "judgment" not "judgment_heavy," and adds a fourth outcome value, "clean_with_correction," not in the documented set. Both are noted here as data-schema facts, not judgment calls.)

Totals: 49 clean, 5 clean_with_correction, 1 defect, 0 abandoned.

**caught_by** (across all 55 rows): `orchestrator_verification` = 1, `implementer` = 5, `n/a` = 49. No row records `escaped_to_human`. No row uses a literal "instructor" value in this column; one note (a8_apply_wk1_rulings) records that the instructor confirmed a flagged contradiction the same night, but the catch itself is attributed to the implementer in the field.

**Send-backs**: 1. Only one row (`survey_design_generator`, 2026-08-17) has `rounds_to_green` = 2; all other 54 rows resolved in round 1.

## 3. Defect and correction rows, individually

| row | date | task | one-line note | classification |
|---|---|---|---|---|
| survey_design_generator | 2026-08-17 | outcome=defect | clearance checked at vertices (PASS) but the path between vertices cut to 1.84 m vs 3.5 m required; fixed in one send-back with continuous sampling at ≤0.25 m | implementer error (geometry), caught by orchestrator_verification |
| a3_wk3_wk5_runsheets_in_room | 2026-08-27 | clean_with_correction | ruling 4.5 as relayed (4 units and keep the 28-min debrief + warm-up + Lin) does not fit in 150 min, off by ~19 min; implementer applied a scaling table and flagged it | orchestrator spec error, caught by implementer |
| a8_apply_wk1_rulings | 2026-08-28 | clean_with_correction | the old script promised the Day-1 slip does not count, while ruling F2 says Daily Inquiry begins Sep 2; implementer made the catalyst graded and flagged the contradiction (instructor confirmed same night) | scouting gap in the orchestrator's ruling text, caught by implementer |
| a9_burger_citation_audit | 2026-08-28 | clean_with_correction | implementer had made an out-of-scope edit to both syllabus .md files and rebuilt their PDFs, then reverted it and documented the open question instead of silently dropping it | implementer self-correction of an out-of-scope action |
| jp1_paper_list_fallback | 2026-08-28 | clean_with_correction | first commit swept a concurrent agent's staged files because `git commit` commits the whole index; implementer self-repaired with `reset --soft` + `commit --only` | process defect (git index sweep), caught by implementer |
| burger_batch2_part3_frames | 2026-08-28 | clean_with_correction | the 47/47/rest frame split as specified left part 3 a single frame; implementer read from the true boundary (2407) and flagged the overlap | orchestrator spec error, caught by implementer |

## 4. What the notes say implementers did well

Six recurring patterns, each with example rows:

1. **Refusing to guess at unreadable or missing data.** `burger_batch2_part1_frames`: "7 UNREADABLE none guessed." `a10_read_burger_frames`: marked shadowed table cells `{{UNREADABLE}}` rather than transcribing uncertain digits. `data_labs_sourcing_scout`, `kilauea_ep50_footage_scout`: honest not-found rather than a fabricated source.
2. **Catching the orchestrator's own spec errors.** `a3_wk3_wk5_runsheets_in_room`: caught a timing ruling that did not fit the 150-minute block. `burger_batch2_part3_frames`: caught an uneven batch-split boundary. `a2_syllabi_governing_docs_notebooks`: found a line the punch list itself had skipped.
3. **Reporting out-of-scope findings instead of expanding scope.** `wk1_notation_burger_R_l`: "reported 4 out-of-scope carriers... instead of silently expanding scope." `a7_source_level_accessibility_fixes`: noticed an overlapping rebuild it had not run and flagged it rather than committing over it.
4. **Re-deriving numbers instead of trusting the input document.** `a8_apply_wk1_rulings`: verified a ruling against the syllabus schedule table rather than the walk-notes paraphrase. `wave1_closeout_pass`: recomputed a sample-CSV intercept and disclosed the generator has no offset. `burger_batch2_merge`: reconciled a table conflict by recomputing to four decimal places.
5. **Self-repairing process defects mid-task.** `jp1_paper_list_fallback`: git index sweep, repaired with `reset --soft` + `commit --only`. `a8_apply_wk1_rulings`: isolated a one-line fix via `git hash-object` after hitting a concurrent agent's edits in the same file.
6. **Disclosing method limits and discretionary choices up front.** `nav_track_statistics`: reported medians with IQR and n, and disclosed its one discretionary clustering choice, because the prompt required it. `earle_reading_verification`: disclosed that a live fetch was blocked and Wayback snapshots were used instead.

## 5. Process rules that emerged during the trial

- **Explicit paths in `git add`, never `-A`, on delegate-touched repos until the delegation resolves.** Recorded in the `banner_generation_port` row after an unverified agent edit was swept into a pushed commit (`f3b0c5f`); the fix was re-verified before committing on the next delegation (`banner_identity_revision`).
- **`git commit --only <paths>`.** Recorded in the `jp1_paper_list_fallback` row after a plain `git commit` committed a concurrent agent's staged files along with the intended change.
- **Worker caps, `floor(24/N)` per concurrent agent.** Stated in `docs/orchestrator_playbook.md` Rule 5 and in the lab-wide `CLAUDE.md` Parallel Worker Cap section; not exercised as a defect in this log (no row records a worker-count incident).
- **Verify before the artifact ships.** Stated in `docs/orchestrator_playbook.md` Rule 2 and its anti-patterns list ("building the delivery package before the verification pass"); the `banner_generation_port` row is the one instance of this being violated, and the following `banner_identity_revision` row records the corrected practice ("5 PNGs verified visually by orchestrator BEFORE commit").
- **Batching rulings for approval fatigue.** Evidenced in the `personality_prose_sweep` row ("nothing applied pending the instructor's batch ruling") and the `a3_wk3_wk5_runsheets_in_room` row (14 WALK markers collected for one batch of judgment calls); the general practice is recorded in the lab's `feedback_pace_decisive` memory note.

## 6. What the rule yields

Reading the outcome field literally: n = 55 (≥10); zero rows have `caught_by = escaped_to_human`, satisfying (a); the one row with `outcome = defect` has `caught_by = orchestrator_verification`, satisfying (b); zero rows have `outcome = abandoned`, satisfying (c) at 0 ≤ 2. All three conditions are met, so the rule yields: continue the pattern as default practice.

### Caveats

- All outcomes are self-reported by the orchestrator model that also ran the delegation; nothing in this log is checked by a party outside that loop.
- The orchestrator wrote every note in the log, including the notes describing its own spec errors.
- Models were not randomized to tasks: opus-5 was assigned to judgment-heavy work and sonnet-5 to mostly mechanical work by design, not by draw.
- opus-5's clean/correction rate is not comparable to sonnet-5's on mechanical tasks, since opus-5 ran almost no mechanical-only load in this log relative to sonnet-5's 25 mechanical-heavy rows.
- Five rows carry `outcome = clean_with_correction`, an outcome value not present in the log's own documented schema (clean/defect/abandoned). Four of those five were caught by the implementer, not by `orchestrator_verification`. Whether those rows count as "defects" under condition (b) is not settled by the rule's text; the verdict above uses the literal `outcome = defect` field, under which only one row qualifies.
- Zero rows are logged as `abandoned`. The playbook itself notes this category "leaves no other trace" if a delegation is silently done by hand instead of specified; a zero count is consistent with the rule's condition (c) and also consistent with under-logging of that category.
