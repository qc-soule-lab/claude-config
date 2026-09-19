*AI-generated draft (Claude, Anthropic), instructor-facing working contract for review. Written 2026-09-19 from Dax's stated division of labor and from CUNY Copilot's own answers to a capability questionnaire put to it the same day. Lab-wide: governs GEOL 16 and GEOL 333/714.*

# AI-assisted grading: who does what, and why

## 0. Verify the tenant before any student work goes in

Asked which product it was, Copilot answered: *"I am M365 Copilot based on GPT-5 chat model. In this chat, I am not running as GitHub Copilot and **I am not authenticated as your CUNY tenant.**"*

The FERPA approval attaches to **Microsoft 365 Copilot via CUNY Login**, which is the university-licensed service approved for non-public, internal and sensitive university data. A Copilot session that is not authenticated to the CUNY tenant is not that surface, whatever the model behind it.

**Before any student work is pasted or uploaded, confirm the session is signed in with the CUNY account and shows enterprise data protection.** Design work, rubrics and prompts carry no student data and can be drafted in any session. Scans of student sheets cannot.

This is the same distinction the GEOL 333 HW0 grading prompt already carries: do not use a personal or consumer Copilot.

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
