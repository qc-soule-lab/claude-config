*AI-generated draft (Claude, Anthropic) — for review. All parameters and figures are derived from version-controlled scripts and data.*

# Orchestrator playbook: lessons from the first real trial

Distilled from a full working session on [Hub] (2026-08-17, misoGoPro repo):
Fable/Opus orchestrating, Sonnet 5 implementing, across five real delegations
(a GeoTIFF→netCDF data export, nav-track statistics mining, a survey-design
generator with figure, an open-access literature hunt with license
verification, and a methods-brief synthesis). Written for any lab machine
running the orchestrator pattern. Evidence-based: every rule below traces to
something that actually happened.

## The pattern, one line

Orchestrator scouts ground truth → writes a fact-dense spec → delegates
mechanics to a cheaper model → **independently verifies against the data, not
the report** → sends precise defects back → commits/ships only after
verification.

## Rule 0: We are science-focused, and that changes everything below

The generic orchestrator pattern is a software-economics story: cheap models
write code, the expensive model reviews diffs, and "verify" means tests pass
and the UI looks right. **That is not our job.** Our deliverables are claims
about the physical world, and the failure mode that matters is not a crash:
it is a wrong number that looks right. Consequences that reshape the pattern:

- **"Verify" means re-derive from the data, not review the output.** A diff
  review, a passing test suite, or a good-looking figure is evidence of
  nothing scientific. Every catch this session came from re-opening the
  underlying file (the netCDF's real variable name, the interpolated path's
  real clearance, the deposited manuscript's real page count).
- **Delegates are the newest vector for Borrowed Assumptions.** A fresh
  implementer will happily inherit a threshold, a footprint ratio, or a Te
  from "the literature" or from its own priors. Every number in a delegation
  prompt must carry its provenance ("footprint = 1.5×altitude, MEASURED on
  J1734 at 5.8 m; re-derive if the camera changes"), and the delegate must
  be told which numbers it may NOT choose for itself. Justifying a parameter
  for THIS dataset is orchestrator work, never delegate work.
- **Defensible Statistics propagates by instruction, not by default.** The
  stats delegate reported medians with IQRs and sample sizes, and disclosed
  its one discretionary clustering choice in the deliverable itself, because
  the prompt required it. Left unprompted, agents report bare numbers.
- **The reproducibility chain is part of the deliverable.** Delegates must
  save the analysis script (ruff-clean, version-controlled), not just the
  result, so every reported number regenerates from tracked code and data.
- **Compliance gates are workflow steps, not overhead.** Licenses, embargoes,
  AI disclosure, and provenance logging run at the same priority as the
  science: a correct result we weren't allowed to produce is a failure.
- **The 80/20 boundary moves.** In dev work, ~80% of tasks are mechanical.
  In science work the mechanical shell is thinner and the judgment core is
  bigger, so delegate less, specify more, and expect the orchestrator's
  verification time to dominate. That time is the product, not the tax.

## Rule 1: Scout before delegating

The orchestrator establishes ground truth FIRST and bakes it into the
delegate's prompt: exact file paths, verified formats/CRS/coordinates, what's
in the venv, which conventions apply. The netCDF-export delegation succeeded
on the first pass **because** the prompt carried the scouted facts ("coords
are pixel CENTERS; off-by-half-pixel is a real bug"; "no xarray in the venv,
use netCDF4 directly"). Cheap models execute well-specified tasks well;
they cannot recover facts you didn't give them.

## Rule 2: Verify against ground truth, never the report (the load-bearing rule)

Three real catches in one session:

1. **A student's self-report had two variable names swapped** ("KeyError:
   'elevation' → used 'altitude'"; the file's variable IS `elevation`).
   Caught only by opening the netCDF. Encoding the report unverified would
   have planted a bug in the curriculum.
2. **The survey-generator's own assertions passed while the geometry was
   wrong.** The implementer checked clearance at waypoint *vertices* (min
   6.01 m, PASS); the actual *path between vertices* cut within 1.84 m of a
   target it was required to clear by 3.5 m. Caught only by an independent
   verifier that sampled continuously along segments.
3. **A repository landing page claimed a "published version" deposit** that
   was actually a 26-page unformatted author manuscript (VoR is ~12 pp).
   Metadata lies; page counts don't.

Verification discipline that made these catches possible:
- **Use a different method than the implementer's own checks.** Their
  assertion sampled vertices → yours samples segments at finer resolution.
  They report md5s → you download the blob back and hash it yourself. They
  claim CSV/UTM consistency → you re-project 10 random rows with pyproj.
- **Seed your random spot-checks** (reproducible), and sample the interior,
  not just corners the implementer already checked.
- **Verify BEFORE the artifact ships anywhere.** A zip built one minute
  before verification contained the defective design and had to be rebuilt.
- **Nothing currently verifies the verifier.** The orchestrator writes the
  check and no independent method confirms it. A verifier that samples too
  coarsely returns PASS and raises confidence while the defect ships, which
  is worse than no check at all. For numbers headed into a paper or a
  student deliverable, the escape is an analytic bound or an independent
  reimplementation, not a finer version of the same check. Unresolved; see
  Open questions.

## Rule 3: Delegation cost = context transfer (know when NOT to delegate)

Science tasks are context-heavy and code-light, the opposite of generic dev
work. A fresh implementer doesn't know the project's hard-won facts (which
color-correction destroys a diagnostic hue; which depth datum carries a ~10 m
offset). Every compression of that context into a prompt is a chance to
reintroduce a borrowed assumption. Consequences:
- Delegate **mechanics** (exports, generators, stats mining, searches,
  renders). Keep **scientific judgment** at the orchestrator: parameter
  choices and their justifications, license/embargo verdicts, what ships,
  vent/datum/threshold decisions.
- The orchestrator writes LONG prompts. A fact-dense 40-line prompt that
  costs 5 minutes prevents a 2-hour redo loop.
- If the task is mostly judgment with a thin mechanical shell, don't
  delegate it.

## Rule 4: The send-back loop (localize first, then one precise message)

When verification fails, do NOT just say "it's broken." Localize the defect
yourself (which leg, which sequence numbers, exact distances, root cause
hypothesis), then send ONE message with the repro + the required fix + the
new acceptance test. The jog-geometry defect was fixed in a single round-trip
because the send-back named the exact waypoints and prescribed
"continuous sampling at ≤0.25 m steps" as the new assertion. Resuming the
same agent (it keeps its context) beats respawning cold.

## Rule 5: Lab rules do not auto-propagate into delegates

Subagents don't inherit the lab's conventions. Every delegation prompt must
carry, explicitly:
- The **verbatim AI-disclosure line** for any prose deliverable (and the
  monospace `<span>` wrapper where the project uses it).
- **snake_case naming, `uv run` invocation, ruff format+check, pytest must
  stay green**, with the expected test count.
- **"Do NOT commit."** The orchestrator commits after verification, always.
- The **worker cap**: the 24-worker ceiling is SHARED, so with N concurrent
  agents, write "use at most floor(24/N) parallel workers" into each prompt.
  (2026-04 container-restart incident; near-miss 2026-04-12.)
- **"Final message = raw data, not prose."** Agents that report numbers and
  paths are verifiable; agents that report narrative are not.

## Rule 6: Compliance work delegates surprisingly well, with a hard protocol

The OA literature hunt worked because the prompt made license verification a
NON-NEGOTIABLE protocol (registry API + OA-status API + in-PDF statement, all
three must agree; explicit CC only; "bronze"/free-to-read = reject), and
required the agent to report its REJECTS with reasons. The rejects were as
informative as the accepts. Then the orchestrator re-verified every accept
independently (fresh API calls, own PDF extraction, an n-gram scan proving no
verbatim leakage from an ND-licensed source). Ethical-check skill runs at the
orchestrator level; delegates get the protocol spelled out, not the skill.

## Rule 7: Observed economics (n=5, one session)

Sonnet 5 implementations: 4 of 5 clean on first pass, 1 real geometry bug,
caught by Rule 2 and fixed in one send-back. Report that as a count, not as
a rate. The Wilson 95% interval on 4/5 spans roughly 0.38 to 0.96, which is
consistent with the "80% of tasks don't need the expensive model writing
code" hypothesis and equally consistent with its opposite; n=5 in one
session on one repo cannot settle it.

What the session does establish is qualitative and still useful: a
well-specified mechanical task is often implemented correctly by the
cheaper model on the first pass; at least one failure was invisible to the
implementer's own passing assertions, which is why verification is not
optional; and time-to-done was dominated by orchestrator verification,
which is the correct place for the time to go. Corollary: the
orchestrator's verification code is itself cheap to write and reusable, so
keep the verifiers.

Defensible Statistics applies to our own process metrics, not just to the
science. Accumulate delegation outcomes across sessions (task, model, clean
or defective, defect class, rounds to green) before quoting any rate.

## Rule 8: Operational footnotes (small, real)

- Session shells inherit STARTUP env; a credential rotated mid-session needs
  an explicit `source ~/.azure/<container>.env` before use.
- Background-agent completion notices are NOT user consent; a question
  pending to the human stays pending.
- Delegates may flag the harness's own injected system notices (date changes,
  etc.) as "prompt injection"; that is benign, so tell them nothing or
  ignore it.
- Agents' own assertion suites passing is a claim, not evidence (Rule 2).
- Before overwriting/deleting anything the delegate produced, re-check what
  else already consumed it (the prematurely-built zip).
- Fable's safety classifiers (cybersecurity, research biology) can decline a
  request. The reply is HTTP 200 with `stop_reason: "refusal"` and empty or
  partial content, not an exception, so an unguarded orchestrator loop stops
  with no error raised. Occasional false positives on benign life-sciences
  work put the scaleworm material in range. Branch on `stop_reason` before
  reading `content` (with `stop_details.category` saying which classifier),
  and opt into server-side fallbacks so a decline re-runs on **Opus 4.8**
  (`claude-opus-4-8` — the only supported fallback target; "Opus 5" does not
  exist) inside the same call: beta `server-side-fallback-2026-06-01` +
  `fallbacks: [{"model": "claude-opus-4-8"}]`. This applies to API-level
  orchestration; Claude Code's own Agent tool handles subagent turns through
  the harness. (This bullet originally named a nonexistent model — caught by
  fact-checking against the API reference, a Rule 2 instance in the playbook
  itself.)

## Open questions (unresolved after one session)

- **What verifies the verifier?** Rule 2 requires the orchestrator's check to
  use a different method than the implementer's, but nothing checks the
  orchestrator's method. Candidates: an analytic bound worked out by hand, an
  independent reimplementation for paper-bound numbers, or a second verifier
  written against the specification rather than against the implementation.
  None tested. **Concrete instance found post-hoc (2026-08-18):** the
  session's survey-design verifier sampled *leg-internal* segments only —
  turn arcs between lawnmower lines were never clearance-checked. Benign in
  that design (turns occur at the box edges, ~40+ m from any vent) but the
  gap was unexamined at verify time; a spec-derived verifier ("every path
  point ≥3.5 m from every vent") would not have had the blind spot.
- **Which model tier for which mechanical task?** The playbook says "a
  cheaper model" throughout, and every delegation this session used Sonnet 5.
  Haiku 4.5 is plausibly sufficient for renders, format conversions, and
  other narrow mechanical work, at a third of Sonnet 5's standard per-token
  rate. The one observed failure was a geometry task, which is weak evidence
  for tiering by how much implicit reasoning the mechanics require rather
  than by how much code they take. Not enough data to set a boundary.

## Trial protocol (2026-08-18 to 2026-08-25)

Run the pattern as written for one week, then evaluate against recorded
outcomes rather than recollection. Rule 7 is unquotable at n=5; the point of
the week is to make it quotable, or to falsify it.

- Log every delegation in `docs/delegation_log.csv`, one row each, at the
  time it resolves. A delegation that is never logged did not happen.
- The field that matters most is `caught_by`: the implementer's own
  assertions, orchestrator verification, or escaped to the human. Rule 2's
  whole claim is that the second column is non-empty and the third is not.
- Record defects that the orchestrator caused too (bad spec, missing scouted
  fact, borrowed assumption passed down in the prompt). Attributing every
  defect to the implementer would make the pattern look better than it is.
- At the end of the week, evaluate three things: the defect rate with an
  interval attached, where defects were caught, and whether orchestrator
  verification time is falling as verifiers accumulate and get reused.
- Also record the pattern's cost in the one currency it cannot recover:
  delegations abandoned because specifying them took longer than doing the
  work. Those are Rule 3 evidence and they leave no other trace.
- Pre-commit the decision rule before the week starts. Deciding on
  2026-08-25, while looking at the numbers, what would count as success is a
  post-hoc threshold, which is exactly what No Borrowed Assumptions exists
  to prevent.

### Decision rule (LOCKED by PI, 2026-08-18 — before any week-2 data)

Continue the pattern as default practice if, over ≥10 logged delegations:

1. **(a) zero defects `escaped_to_human`** — every defect was caught before
   reaching the PI or a shipped artifact;
2. **(b) every defect was caught by `orchestrator_verification`** — the
   independent verify layer, not luck or the implementer's own assertions;
3. **(c) ≤2 delegations `abandoned`** because specifying cost more than
   doing the work directly.

Any escaped defect = revert to hands-on for that task class pending a
post-mortem logged in this file. If fewer than 10 delegations accumulate by
2026-08-25, extend the window rather than judging on thin data — the rule
binds at n≥10, not at the calendar date.

## Anti-patterns seen or narrowly avoided

- Trusting a vertex-sampled geometry check for a path-clearance requirement.
- Encoding a human's (or agent's) self-report into curriculum/code without
  opening the underlying file.
- Building the delivery package before the verification pass.
- Letting a delegate pick its own worker count.
- Treating "free to read" as "licensed to feed."
