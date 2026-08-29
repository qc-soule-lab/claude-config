*AI-generated draft (Claude, Anthropic), for review. Machine handoff written on the [MacBook] 2026-08-28, end of session, for the iMac. Paths under `~` resolve per machine (`/Users/daxsoule` on the iMac).*

# MacBook to iMac, 2026-08-28: expense update + GEOL 333 pickup receipt

Two workstreams this session. Nothing in this handoff requires re-doing work; it is a receipt of what the MacBook did and where the pending items sit.

## Pull / sync

- `git -C ~/repos/claude-config pull` (this primer is the only new commit).
- **No course repo changed on the MacBook.** `geol-333-fall-2026` (branch `restructure-rebalance-2026-06-21`) and the public `geol-333-714` were pulled here, not committed to. The iMac is already at or ahead of what the MacBook has.
- **The expense work travels by Dropbox, not git.** Folder: `~/Queens College Dropbox/.../Research/Expenses/OverheadAccount/OH_2026/08_12_WHOI_Visit/`. If any file there shows 0 bytes on the iMac, it is an online-only placeholder: right-click, Make Available Offline. That bit the MacBook today (`trip_justification.md` and `provenance_notes.md` were 0-byte placeholders until Dax hydrated them).

## WHOI expense report (Dropbox folder above; provenance_notes.md is the canonical log)

1. **Trip justification gained the meals paragraph** (his ask): $100 = 75% of the $80 Plymouth/Taunton/New Bedford M&IE tier per travel day ($60 each), less the $20 furnished hotel breakfast on 08/13. `trip_justification.pdf` re-rendered from the md (WeasyPrint, layout matched to the 08-18 original) and overwritten in place.
   - **Trap recorded for future compliance prose: read the provenance notes before writing.** Working only from the voucher and the GSA screenshot, the first draft inferred "a rounded $100 under a $129 Falmouth-rate cap", which is wrong. The notes record the real derivation ($80 Somerset tier, breakfast deduction, and the rejected $102.50 Falmouth alternative). The hydrated true source is what caught it.
2. **Mileage rate discrepancy found at system entry, PENDING.** The Payment Request System applies $0.725/mile; the voucher claims $0.760. Both are real GSA rates: $0.725 effective Jan 1 2026, $0.760 effective Jul 1 2026 (mid-year increase, verified against gsa.gov 2026-08-28). Travel began 08/12, so $0.760 governs per GSA's own instruction and RF's Allowable Transportation policy. Stakes $18.06 (total $744.98 vs $763.04).
   - Filed in the folder: `email_rf_mileage_rate.md` (draft to epayhelp@rfcuny.org, disclosure line to strip before sending) and `gsa_pov_rates_2026-08-28.pdf` (rendered GSA text, labelled as a rendering, not a screenshot).
   - **Next actions are Dax's:** send the email; on RF's answer, either the system rate gets corrected or the voucher regenerates at $0.725 and provenance gets the closing entry.

## GEOL 333/714: the MacBook completed the 08-28 pickup, no course work started

Per the iMac's own primer (`macbook_primer_2026-08-28_geol333.md`): repos pulled (build repo at `7fa5287`+, the Burger problems index `9ee07a2` and both proposals landed), public repo cloned fresh on the MacBook at `ff070e1`, allowlist re-added to the MacBook's `~/.claude/settings.json` (validated; Dropbox deny rules and hooks intact), and MacBook memory written: `feedback_approval_fatigue`, `feedback_git_commit_only`, and `project_geol333_cruise_walk` (the MacBook never had one; its stale at-sea framing is now marked superseded in `geol714_brightspace_build.md` and the index).

**The coverage-priority walk did NOT start.** Next Claude work on either machine is unchanged from the iMac's primer: walk `records/burger_coverage_priority_wk3_wk5_2026_08_28.md` with Dax, one decision sheet per meeting (Wk 3, then 4, then 5), then rebuild the A3 runsheets backward from the chosen anchor problems. Fable orchestrates; Opus and Sonnet implement; agents commit `--only`.

## Machine notes

- [MacBook] WeasyPrint needs `DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib` when run outside the repo venvs (same lesson as `build_syllabus.py`'s shim).
- [MacBook] `gsa.gov` is fetchable from this machine (unlike `usgs.gov`/JPL). The GSA POV page redirects once; follow with `-L`.
