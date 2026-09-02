*AI-generated draft (Claude, Anthropic), for review. Written on the MacBook late 2026-09-01, handing back to the iMac for the HTML work.*

# Handoff to the iMac, 2026-09-01 late evening

**GEOL 333/714 meeting 1 is tomorrow, Wed Sep 2, 4:35 PM.** He is doing the HTML and shell work tonight before bed.

## Do this first

1. **Pull.** Four commits landed on the MacBook after `ee99fc6`.
2. **Rebuild `bring_list.pdf`.** It is the one podium document that went stale tonight: it still carries the old TBD 5 wording, "post to Brightspace before Sep 2", and the paper list has moved to Thursday Sep 3. The other three Wk 1 pack PDFs are clean, checked by extracting their text. The MacBook cannot rebuild any of them: WeasyPrint.
3. **Paste the eight rebuilt pages plus the welcome announcement**, from the committed HTML. This was owed from the previous handoff and did not happen on the MacBook, because pasting is browser work.

## What the MacBook did, and what it deliberately did not touch

**Nothing under `docs/brightspace/` was rebuilt or edited.** Instructor directive, tonight: do not clobber the links again. Verified before handing back: `git diff ee99fc6 HEAD -- docs/brightspace/` is empty, so both HTML sets are byte-identical to what the iMac pushed. The MacBook could not have rebuilt them anyway, because the page-map preflight refuses there.

**The three Wk 1 runsheet items are done** (`a567fd2`), two of them correctness rather than prose:

- The orphaned `→ catalyst` SVG line is gone from the pre-stage sketch. It was the wrapped tail of the A4 rhythm, left behind when last night's edit cut the A3 and A4 text elements, and it was the last fragment of exactly the board promise the rewritten §11 says no longer exists. Verified by rendering the page and looking at it.
- **The exam-materials line no longer forbids the required calculator.** The policy row and the Block 9 Beat 3 SAY said "nothing printed, nothing on a screen" while the syllabus requires a standalone calculator. Both now name the calculator and ban phones and laptops instead, because a calculator has a screen.
- **The Block 9 Beat 2 pitch no longer sends the room to a list that will not exist.** It names Thursday September 3. The pre-class checklist now asks for the **named round assignments** on the selection thread, which is what is actually owed tomorrow, and TBD 5 records the move. The claim deadline is unchanged: it was always the Wk 2 meeting.

**Four notebooks are through the expressiveness pass**, all markdown only, no code cell touched, cell counts unchanged, each validated and the two runnable ones executed end to end:

| Notebook | Findings | Build | Public |
|---|---|---|---|
| `lecture_01_onramp` | 16, applied 15 | `97cda23` | `485d30f` |
| `HW0_pendulum` | 15, applied 14 | `af606a9` | `1485846` |
| `HW1_stairwell` | 9, applied 9 | `97a6657` | `54c4d64` |
| `week_02_lsq` | 7, applied 7 | `97a6657` | `54c4d64` |

Two findings were declined with reasons, both recorded in the commit messages: the onramp's plain "we" is literal in a notebook the class runs together, and HW0's slope/intercept antithesis was cut because the sentence after it already carried the meaning.

**The reflection question was ruled and applied in all three copies** (`93040a1`, public `dba2068`). The ungraded slot stays; the feelings framing goes. HW0 Q6.3 now asks which part the student would want more time on; HW1 Q6.3 and HW2 Q10.5 ask which result they least expected and what they would check to test it.

## Still open

- **`HW2_profile` seven items and `HW5_refraction` nine.** Both MacBook-safe. HW2 is not in the public repo, so it needs no republish; HW5 still carries the old Colab-deletes banner and is the last copy that disagrees with the other three.
- **The Brightspace markdown's fifteen expressiveness findings, plus one in each of the syllabi, a handout and a rubric.** These are iMac work: editing the sources means rebuilding HTML or PDFs.
- **A wrong hash in a commit message.** `93040a1` names the public commit as `bbd3b06`; the real one is `dba2068`. Not amended, because that would mean force-pushing a branch two machines pull. Left as a known provenance error.
- **`test_missing_links.py` fails on any machine without the page maps**, so the MacBook suite is permanently `6 failed, 77 passed, 3 skipped`: four WeasyPrint plus these two. A suite that is red by default stops being a signal, which is the same failure mode that let 264 links vanish unnoticed. The proposed fix is a skip when `audit_pages_map` reports a missing or stub map, reusing the helper the build guard already uses. **Not implemented; the instructor did not rule on it.**
- **Panel B of the pre-stage sketch still does not draw.** Cosmetic only: the `board_prestage.pdf` renders the bullet list, not the SVG, so it never reached the podium.
- **DRIVE-requires-SAY in `weekly_runsheet_template.md` was Claude's promotion, not an instructor instruction**, and is still un-ruled from yesterday.

## Repo state, all pushed and clean

- `class_dev/geol-333-fall-2026` @ `restructure-rebalance-2026-06-21` `97a6657` **PUSHED**
- `class_dev/geol-333-714` @ `main` `54c4d64` **PUSHED**
- `class_dev/geol-16-fall-2026` @ `main` `f9e30b9` **PUSHED**, untouched
- `claude-config` @ `main` **PUSHED** (this file makes it dirty until committed)

MacBook commits tonight: `97cda23` onramp, `a567fd2` the three runsheet items, `af606a9` HW0, `93040a1` the reflection question, `97a6657` HW1 and week_02.

Duplication ratchet reports 0 new. GEOL 16 meeting 2 is tomorrow morning and nothing on it was touched today.
