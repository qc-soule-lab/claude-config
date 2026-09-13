*AI-generated draft (Claude, Anthropic), for review. Session note for 2026-09-13 [iMac], spanning GEOL 16 and GEOL 333/714. Commit hashes and test counts are read from the repos.*

# 2026-09-13 [iMac]: GEOL 16 shipped for Monday; 714 worked by three agents

## GEOL 16 — PUSHED, `main` at `e976b7d`

Monday's meeting 4 is ready. **23 commits, 381 tests green, pushed.**

**The through-line of the day was a single defect class: artifacts disagreeing with what the room actually saw.**

- **The Class 3 recap was never posted.** Classes 1 and 2 each had a PDF in the shared folder; Class 3's was built 09-12 and never left the meeting folder. Now posted, 21 pages.
- **Its key-terms slide was Class 2's list under a Class 3 title.** His catch, via Nebula Theory. All six original lines were his Class 2 vocabulary. What stays is only what was marked in yellow on slides 1 to 20. `tests/test_mtg03_as_taught_key_terms.py` enforces it.
- **Meeting 4 slide 31 carried the pre-correction copy of that same list** and would have contradicted the PDF in front of students. Trimmed to the Class 2 lines only, heat block kept, because meeting 4 teaches it.
- **Meeting 4 was split before it was taught, not after.** Meeting 3 stopped at 20 of 33 and was split afterward, which is how Monday's reading went unassigned. Monday's deck is 34 slides ending on the closing block; the magnetics block is a 10-slide meeting 5 seed.

**Built:** the paper exit slip (matching quiz plus two catalysts, name and code on the other face, 50 sheets), the Module 1 glossary (25 entries, 14 external links all verified), the Data Lab 3.2 short-answer quiz (8 written-response items), and one announcement covering slides, glossary and both data labs.

**A hazard guarded:** `build_mtg03_as_taught.py` writes a seed whose filename matches the built meeting 4 deck. Re-running it would have replaced tomorrow's 34-slide deck with an 11-slide seed. It now refuses unless the file is seed-sized; `--posted-only` skips it.

**Found while building the glossary:** Brightspace frames content topics, so external links without `target="_blank"` render as "refused to connect". All 14 glossary links lacked it, **and so did 26 others across the site, including the Wegener and Tharp videos on `page_mtg04`**. Fixed as a build-time pass.

**Not a bug:** Acrobat threw "problem reading this document (11)" on every PDF, including one printed successfully last week. Acrobat was mid-update (`AcrobatDCUpd2600221901_incr.pkg` installing). Preview opens everything.

## GEOL 333 / 714 — LOCAL, `restructure-rebalance-2026-06-21` at `9e8e655`, **10 commits unpushed**

`PUNCHLIST.md` gained a numbered index, 1 to 15, ranked by deadline then by student impact. History below it is unchanged, verified by diff.

**Ruled today:** item 9 (convert Q2 to Module 0 statistics), item 10 (cut all four Week 4 blocks, not move them to Week 5), item 13 (JP2 takes prospection from JAG or JEEG). Item 12 deliberately unruled — he said he did not understand the question, so an explainer was written instead.

**Three agents ran concurrently, 8 workers each. All committed, none pushed.**

- **Midterm 1 Q2 conversion** (`04d06a7`). Every number re-verified against `pendulum_inclass.csv`. Module 0 goes 12.0% to 22.7%.
- **Checkpoint 1 and the stale date** (`21b6721`, `43b2d02`). The punch list said four surfaces carried Oct 28; a full grep found **28 occurrences across 18 files**. The December 2 scaffold problem was solved by moving the selection guidelines to `finding_papers.md`, unfenced, so they reach both courses.
- **HW1 vetting** (`9b4fdc6`, `11cae17`, `22d536e`). **Item 5's premise was wrong:** corrected and uncorrected gradients differ by 0.31σ, so no band on the gradient can discriminate. The test moved to the ground-read closure, 7.7× margin. Q6.1 rewritten to ask which assumptions broke and which went untested; that commit is isolated so it reverts alone.

## Owed, and why each is still owed

**His, cannot be delegated:**
1. GEOL 16: paste the announcement; it is the last thing and everything it names now exists.
2. 714 item 1: the Lin reading's durable copy sits inside the 714 fence, so a 333 student's week page says nothing about it. **Matters Sep 16.**
3. 714 item 2: re-paste `assignment_jp1` in both shells and `page_wk3` in 714.
4. 714 item 8: confirm whether two date-pressured announcements posted. Their "Not posted." banners were already wrong once this term.
5. Paste `assignment_clr` and `finding_papers` before the Checkpoint 1 announcement goes out; rename the Brightspace Checkpoint 2 topic, still titled "due Wed Oct 28".
6. Run the publish commands in `records/hw1_defect_repairs_2026_09_13.md`. **`test_public_notebooks_are_not_stale` fails by design until then.**

**Unruled:** item 12 (explainer written), the two sentences on the CLR assignment encoding packet decisions 2 and 3, packet decisions 4 and 5, the seven Week 3 vetting-ledger items, and whether Q6.1's rewrite stands.

**A conflict nobody has resolved:** both Midterm 1 files say **Wed Oct 7**; the punch list says **Oct 14** after the Weeks 6/7 swap. One is wrong and it is on the paper students sit.

**A wording error inside ruled text:** Q2b says two stations "each timed five swings". The protocol is five trials of ten swings.
