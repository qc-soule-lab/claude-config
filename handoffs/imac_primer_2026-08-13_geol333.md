*AI-generated draft (Claude, Anthropic), for review. Machine-transfer primer written on the MacBook 2026-08-13 for the iMac's next GEOL 333/714 session. Paths use `~` (= `/Users/daxsoule` on the iMac).*

# iMac primer — GEOL 333/714 pickup (2026-08-13)

## Read this first

The iMac's local Claude memory predates one MacBook session (2026-08-12 evening through late night, commits `680ec1d`..`bdab2d2`) on the 714 Brightspace shell. That session extended the iMac's own 2026-08-11/12 work, so the iMac memory is stale on JP1 and the round-assignment design. Sequence:

1. `cd ~/repos/class_dev/geol-333-fall-2026 && git pull --ff-only` (branch `restructure-rebalance-2026-06-21`; MacBook pushed through `bdab2d2`, everything committed, nothing local).
2. Read `PUNCHLIST.md` top block ("714 shell go-live" + "Week 1 completion punch list"): canonical state.
3. Read `docs/lesson_plans/shell_change_log.md` (rows dated 2026-08-12) for exactly what is live in the shell.
4. Reconcile the iMac's memory to those two files; rewrite its stale GEOL 333/714 entries.

## What the MacBook session did (2026-08-12)

- **Math Reference Cards page corrected + pasted.** The 2026-08-11 re-push of it had never landed on the live page. Consequence: the other 8 topics in that banner-strip batch were logged "pushed + link-verified" but the row cannot be trusted; they need a paste audit (open item 5).
- **JP1 built end to end.** Rubric instance (`docs/rubrics/rubric_jp1.md`, Template 2 + new earned-LO6 "Method fitness and critical evaluation (15)"; Content 25→20, Methods 25→20, Q&A 20→15) signed off, rendered (`outputs/rubrics/rubric_jp1.pdf`, 3 pp), delivered to Dropbox `handouts/`, share link wired into the assignment page. Framework matched (fifth "Judge the method" move; student-facing LO section, deliberately unnumbered). Assignment page (`docs/brightspace/assignment_jp1.md`) drafted, walked, pasted 3×. Shell objects created: JP1 anchor dropbox (Grade Out Of 100 in Journal Presentations, due Sep 30 4:35 PM), "JP1 paper selection" discussion topic (id 1828371, hyperlinked from assignment + Week 1 Guide), JP1 Audience Peer Review dropbox (`assignment_jp1_audience.md`, due Sep 30 7:05 PM, completion, opens Wk 5). All 714-shell JP1 objects are done. The 333-only JP1 Peer Evaluation object belongs to the future separate 333 shell, not 714. Peer-eval form header Oct 9 → Oct 2 fixed.
- **One journal presentation per unit** (enrollment-driven: 12 grad + 4 UG = 13-14 units; two talks each broke the 150-min nights). Each unit presents at JP1 (Wk 5 gravity) OR JP2 (Wk 9 magnetics); one talk = the full 10%. Ripple applied through syllabi + PDFs (overwritten in place on Dropbox), assignment_jp1, page_wk1, both frameworks, gradebook description, discussions prompt, Wk 1 runsheet.
- **Superseded the same night by ASSIGNED ROUNDS** (`15af5a2`): rounds are assigned, not chosen. UG group(s) → gravity; grads split alphabetically first-six/last-six; named assignments post to the selection topic Sep 2; no caps or tiebreaks. Plus a reassuring-voice sweep (fairness-assurance lines cut across assignment_jp1, audience instructions, page_wk5/wk9, JP1 framework, rubrics jp1/hw1/hw2, peer-eval form). All five shell surfaces re-pasted; the shell is CURRENT with the final design.
- **JP1 paper list is a Brightspace PAGE, not a PDF** (`docs/brightspace/jp1_paper_list.md` + built HTML). NINE papers: Nettleton out, Harris 2013 in at slot 4, Mendez 2016 at slot 9, Paine 2012 at slot 10; Wang retired to Wk 5 case-study material (`bdab2d2`, the seismic test of Lin 1990 in the runsheet spine core). Dax eyeballed all DOIs 2026-08-12 ("the rest look good").
- **Wk 1 runsheet revision applied** (`f7a08b8`): trig 25→15, stats segment in Block 7, JP1 pitch in Block 9, buffer 5.
- **Binding instructor decisions** (beyond JP1): curated list ONLY, no student-supplied papers; assignment pages speak in Dax's first person ("I confirm selections"), reversing the R2 third-person rule for this genre; 333 gets its own separate course shell, 714 builds carry zero 333 content; simplification standard = short sentences, lists wherever possible; all Daily Inquiry items are out of 100 (0 or 100 completion).

## Working conventions (unchanged)

- Repo-first; `pbcopy < docs/brightspace/html/<topic>.html`; Dax pastes via D2L Source Code view; same-day `shell_change_log.md` row; never route Brightspace-bound text through terminal output.
- Student-facing prose: flat register, no AI tells, no em-dashes, no fairness assurances, no internal codenames.

## Open items, in priority order

1. **JP1 paper list: QC Rosenthal access check, then post** (HARD DEADLINE: before Sep 2). Three platforms cover all nine papers: GeoScienceWorld/SEG (Butler, Peters, Allis, Abbott, both JEEG), science.org (Battaglia), Wiley (Pool); Mendez is USGS public domain. Then: flip the framework §3 markers → Dax creates the "JP1 Paper List" topic in Week 1, pastes, sends the URL → wire it into the assignment_jp1 placeholder + page_wk1 + the topic description → re-pastes.
2. **Week 2 pass** (gates activation): Week 2 Guide wording pass, description paste, collection-sheet PDF to Dropbox + link, HW1 dropbox build, rubric_hw1 chain, `week_02_lsq.ipynb` re-cast.
3. **JP1 framework fake-expressiveness pass** before it posts ("say what it would buy", "beats five name-drops" flagged).
4. **Sep 2, from the final roster**: post named round assignments to the selection topic + set the per-student grade-item exemptions (both on the Wk 1 runsheet pre-class checklist).
5. **08-11 banner-strip batch paste audit** (8 topics; the math-cards failure showed the batch row can't be trusted).
6. **HW0 notebook republish** on pendulum-kit arrival (ordered 2026-08-12): verify kit → decide Q5 → republish. Dataset URL blessing still open.
7. Then: flip the course Active (go-live step 8) + log it (step 9).

## Deadlines

- **Sep 2 (first class)**: JP1 list posted; round assignments posted from the roster; Module 0 Week 1 fully live.
- **Sep 10-30 at sea**: Wks 3-5 LIVE SYNCHRONOUS online from the ship; Zoom links via Brightspace Announcement.
