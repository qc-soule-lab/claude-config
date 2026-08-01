*AI-generated draft (Claude, Anthropic) — for review. Machine-transfer
primer written on the MacBook 2026-07-31 for the iMac's first session
after ~6 weeks offline (since ~mid-June 2026).*

# iMac primer — first session after 6 weeks off

## Read this first

The iMac's local Claude memory (`~/.claude/projects/.../memory/`) is
~6 weeks stale and predates everything below. Do NOT trust it for
project state: read this primer and each repo's `CLAUDE.md` handoff,
then update the iMac's memory to match before doing any work. Paths
here use `~` (= `/Users/daxsoule` on the iMac).

## First actions, in order

1. `cd ~/repos/claude-config && git pull --ff-only` (you are reading the
   pulled copy — done).
2. `cd ~/repos/loc_science_dev/bravoseis_orca_3d && git pull --ff-only`,
   then read its `CLAUDE.md` **Current handoff** block — it is the
   canonical, current state of the active project.
3. Reconcile the iMac's memory files to this primer + that handoff;
   delete or rewrite stale entries rather than letting them mislead.
4. Gitignored data working copies are NOT in git: re-pull from the Azure
   `bravoseis` container per the repo docs if a task needs them
   (`source ~/.azure/bravoseis.env` + `tools/azure_lake` in this repo;
   **SAS expires 2026-08-31** — renew soon).

## Deadlines (check these against today's date immediately)

- **GRTI 27 equipment proposal: DUE 2026-08-03 17:00** — three days
  after this primer was written. Repo `~/repos/forms_dev/qc_forms` /
  `proposal_dev` context; last-known blockers: email attachments,
  faculty partners, quotes. If today is past 2026-08-03, treat as
  closed and ask Dax what happened.
- NSF 26-512 "AI Datasets" planning proposal: due 2026-11-04
  (`~/repos/proposal_dev/proposals_2026/nsf26_512_ai_datasets`).
- GEOL 333 (Fall 2026): Dax is at sea Sep 10–30; weeks 3–5 must be fully
  asynchronous and pre-recorded before Sep 10
  (`~/repos/class_dev/geol-333-fall-2026`; platform = Colab + ERDDAP).

## Lab-wide rule changes since mid-June (already in this repo's CLAUDE.md)

- **No personality in AI prose** (2026-07-28, lab-wide): flat factual
  register in every AI-drafted document for human reading; no rhetorical
  antitheses, no anthropomorphism; no internal codenames (T/D-numbers)
  or process-gating language in reader-facing docs.
- Figure SOP: all text ≥7 pt AT FINAL RENDERED SIZE.
- Pre-registration discipline is in active daily use (constitution
  v1.5.0+ in the Orca repo): no fit runs before a committed,
  PI-approved pre-registration.

## Active project: BRAVOSEIS Orca 3-D (`~/repos/loc_science_dev/bravoseis_orca_3d`)

Six weeks ago the project was mid-spec-003. Since then, in one line per
event: spec-003 merged; reduction density flipped to 1.64 (T14 settled);
the 48-line full-field lever was tested and FAILED (null off-ramp
holds); the project CONVERGED on a bound, |Δρ| ≤ ~708 kg/m³ 2σ, not a
measurement; delivery re-cut into six section packets with Colab
notebooks vetted via circles of trust (circle 1 = J. L. Granja-Bruña +
J. Almendros); packet S1 is a 12-page PDF in PI review round 2
(comments 1–8 applied, round open); the 2019 tie-line leveling was
recovered from the archive, tested under pre-registration, and FAILED
(neither transferred 2019 corrections nor a fresh crossover adjustment
reduces the held-out floor; both breach the caldera leakage guard); the
raw 1 Hz gravimeter archive showed `G_obs` = raw meter + ONE cruise
constant — **no drift/tide correction or filtering ever existed in any
chain** (confirmed against the parallel `*_Geoff` chain and the cruise
report, which contains no tie or drift record and whose 28 Jan 2019
watch log saw the noise at sea); the published BAC.grd and its whole
chain are Dax's own (Geosoft lineage); a map-vs-crossover test showed
the re-gridded lines reproduce the published map to 0.65 mGal (the
noise is smooth along-track wander — maps hide it, only crossovers see
it). **NEXT LEVER (blocked on 6 PI decisions):**
`docs/timedomain_adjustment_preregistration_2026-07-30.md` (DRAFT) —
tide + smoothed-nav Eötvös + 240 s low-pass + crossover-constrained
drift spline in cruise time. Key docs, newest first:
`timedomain_adjustment_preregistration_2026-07-30.md`,
`cruise_report_gravity_findings_2026-07-30.md`,
`geoff_chain_crosscheck_2026-07-30.md`,
`bac_grd_provenance_2026-07-29.md`,
`raw_gravimeter_first_look_2026-07-29.md`,
`leveled_refit_preregistration_2026-07-29.md` + result tables.

Machine roles unchanged: code on any machine via git; data stays on
Azure; Oasis Montaj/gxpy legs run on the [DellPC] only. The packet
renderer, fit pipeline, and all diagnostics run headless on any Mac
(pytest 118 passed / 9 skipped at tip `c9d27eb`).

## Waiting on Dax (as of 2026-07-31)

1. Six §8 decisions on the time-domain pre-registration (blocks the
   noise-floor work).
2. Fresh read of the 12-page S1 packet → close round 2 → ship/hold call
   for circle 1; then the three S1 Colab notebook decisions (hosting,
   EN vs EN+ES, noise cell).
3. The J. L. Granja-Bruña conversation (agenda: BAC.grd provenance
   answer, no-drift finding, UTM/ship tie-sheet ask, BA_Catalan origin,
   regional question).

## Small open items

- Unreviewed DellPC commit `928754f` (adds the raw 1 Hz meter chain to
  the archive_2019 export) — review before starting pre-reg Stage 0.
- T15 magnetics provenance: both processed anomaly chains are on Azure
  (`open_exports/archive_2019/magnetics/`), untouched frontier.
