*AI-generated draft (Claude, Anthropic), instructor-facing working contract for review. Written 2026-09-19 from Dax's stated division of labor and from CUNY Copilot's own answers to a capability questionnaire put to it the same day. Lab-wide: governs GEOL 16 and GEOL 333/714.*

> **⚠️ REVERSED 2026-09-20. Read this before anything below.** His ruling: *"I want to do most things in claude, and then have copilot only handle matching names to identifiers."* His assessment of the grader: *"copilot is pretty bad it is not very useful."*
>
> **The division below is superseded.** The current split:
>
> | Stage | Who |
> |---|---|
> | Design, and **grading the de-identified work faces** | Claude |
> | **Reading the name faces only**, to pair each identifier with a student | CUNY Copilot |
> | Merging that pairing into the ledger | script |
> | Confirm, override, assign, release | Dax |
>
> **What makes this compliant, and the condition it rests on.** The GEOL 16 Meeting 4 sheets are CODED: the front carries name, class number and identifier; the back carries the identifier and the answers and **no name**. A scan of the back is therefore de-identified, on the same 34 CFR 99.31(b)(2) basis already recorded for the GEOL 333 cards. **Claude must never receive the front faces, and must never receive the identifier-to-name mapping.** If both reach one conversation the de-identification collapses and this arrangement is void.
>
> Everything else below still holds: models never write student-facing prose, feedback is emitted as codes from an approved bank, deterministic steps stay in scripts, and no grade or feedback is released without his approval.


# AI-assisted grading: who does what, and why

## 0. The tenant, and why a model's self-report is not evidence about it

**Settled 2026-09-19: Dax is signed in to Copilot with his CUNY login.** The session is the approved surface and student work may be pasted into it.

This needed settling because Copilot, asked which product it was, answered: *"I am M365 Copilot based on GPT-5 chat model. In this chat, I am not running as GitHub Copilot and I am not authenticated as your CUNY tenant."*

**That claim was wrong, and the general lesson is worth more than the specific correction.** A model has no reliable view of its own runtime: which tenant it is in, what data protections apply, what tools it holds. It produces a plausible sentence about its configuration the same way it produces any other sentence. The instructor's own sign-in is direct evidence; the model's introspection is not evidence at all. The most likely reading of what it said is that it has no tenant-data grounding in the conversation, which is a different thing from enterprise data protection being off, but that reading is also a guess.

Apply the same scepticism to any capability claim. When Copilot was asked whether it could open a pull request it answered no, which is checkable and consistent with the product. Had it answered yes, the answer to verify it would have been to ask it to actually do something small, not to believe it.

**What remains operationally true:** the approval attaches to Microsoft 365 Copilot via CUNY Login. A personal or consumer Copilot is a different product and is not covered, which is the distinction the GEOL 333 HW0 grading prompt already carries.

## 1. The three roles

| Stage | Who | Output |
|---|---|---|
| **Design** | Dax and Claude Code | Rubrics, answer keys, misconception catalogs, feedback banks, grading prompts, calibration anchors, Brightspace templates, playbooks. Version-controlled, tested. |
| **Assess** | CUNY Copilot | Scores against the rubric, feedback drafted as codes from the approved bank, consistency checks, misconception tallies, instructor review packets. |
| **Confirm** | Dax | Reviews, overrides, assigns the grade, releases to students. |

Copilot proposed the same split in its own words: *"Claude Code: assessment design, rubrics, answer keys, feedback banks, repo maintenance. Me: assessment against established standards, feedback drafting, consistency checking, analytics, instructor review packets. You: final academic judgment and release."*

## 2. Why the design layer lives with Claude, and it is not territorial

**Copilot cannot read the repo.** Its own answer: *"No, not from the repository itself. I can only read content that you paste, upload, or otherwise provide in the conversation."*

Asked separately what it expects to produce, it listed rubrics, answer keys, misconception catalogs, feedback banks and grading prompts. **Those two answers cannot both drive the work.** An artifact authored by a tool that cannot see the repo is authored blind to the current syllabus, the delivered deck, the test suite, and the other artifacts it has to stay consistent with.

That failure has already happened once inside a single repo: `geol-16-fall-2026/docs/quizzes/meeting_04_exit_slip.md` describes a combined exit-slip-plus-catalyst sheet that the meeting 4 deck does not contain, and it was written from a planning file rather than from the deck as delivered. Two authors, one of them unable to read the repo, multiplies that.

**So design artifacts are authored where they can be checked against their sources.** Copilot's contribution to the design layer is amendments, not authorship: it proposes a change, in prose or as a delta, and that comes back through Claude so one source of truth is edited, tested and committed.

## 3. Git topology: there is nothing to coordinate

Copilot cannot clone, commit, push or open a pull request. Its own answer: *"No."*

So there is **no concurrent-writer problem and no second repo is needed.** Everything Copilot produces reaches the repo the same way any of Dax's own writing does: he saves it and commits it. That paste is not friction around the gate; it **is** the confirm step, expressed in git.

The earlier proposal for a Copilot-owned `docs/grading_runs/` directory with `git commit --only` was built for a writer that does not exist. What survives from it is smaller and still worth having: **one aggregate run record per graded assignment**, written after a run, carrying tallies and calibration numbers and no student identifiers. Dax commits it like anything else.

## 4. Every grading prompt must be self-contained

This follows directly from Copilot not being able to read the repo, and it is the rule most likely to be broken by accident.

A grading prompt may not say "apply the rubric in `rubric_x.md`". It has to **carry** the bands, the boundary tests, the misconception codes and the feedback codes inside the pasteable block, because the grader cannot open the file. `geol-16-fall-2026/docs/rubrics/copilot_grading_prompt_geol16_mtg04_daily_inquiry.md` is the worked example: the instructor pastes one block and attaches scans, and nothing else is required.

**Consequence for maintenance:** the prompt duplicates the rubric by design, so the two can drift. Every rubric edit requires the same edit in its prompt, and the prompt's header names the rubric it encodes so the dependency is visible.

## 5. Feedback reaches students as codes, not prose

Copilot emits feedback **line IDs**. The approved feedback bank in the repo supplies the words. Approving a bank once approves everything that reaches a student, completely rather than by sampling, which is what makes "my eyes approve anything that goes back to a student" survive a full roster.

A grading prompt therefore gives Copilot the codes and their firing conditions, and forbids it to write feedback sentences.

## 6. What never enters git

Both parties agree on this line, and the guards already enforce it. Copilot's own words: *"I would keep all student-identifiable work out of GitHub, even private GitHub. The repository should contain course artifacts and grading systems, not student records."*

| Artifact | Where it lives |
|---|---|
| Scans of student work | Dropbox, in the course's anonymously-graded tree |
| Per-student scores, feedback assignments, grade exports | Dropbox, or Brightspace, which is the system of record |
| The code-to-name key, where one exists | One machine, never synced |
| Named hand-back slips | Generated, printed, discarded. Not stored. |
| Aggregate tallies, calibration numbers, flag counts | The repo, in the run record |

Enforcement already in place in `geol-333-fall-2026`: `build_grading_packet.check_destination()` refuses to write a real card's packet inside the repo, and a `.gitignore` block covers scans, slips, keys, rosters and score sheets. Both tested. `geol-16-fall-2026` has no equivalent guard yet and should get one before its first scanned batch.

## 7. Formats

Copilot's stated preferences, adopted:

| Content | Format |
|---|---|
| Policies, rubrics, playbooks, feedback banks, run records | Markdown |
| Machine-readable configuration | YAML |
| Grade exports and review tables | CSV, and these do **not** go in the repo |

## 8. Deterministic steps stay out of both models

Code-to-name joins, PDF splitting, grade merges and file renaming are scripts. They have exactly one correct answer, so a model adds nothing and can fail silently in a way that hands one student another's work.
