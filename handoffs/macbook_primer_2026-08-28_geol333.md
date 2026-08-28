*AI-generated draft (Claude, Anthropic), for review. All parameters and figures are derived from version-controlled scripts and data.*

# Machine handoff: iMac to MacBook, 2026-08-28

Written at the end of a full [iMac] day on GEOL 333/714 (Fable orchestrating Opus and Sonnet; 15 delegations, all in `docs/delegation_log.csv`). Dax is moving to the [MacBook] to run the Wave 1 Brightspace sitting. First class is **Wednesday Sep 2**.

Everything below is pushed. The [MacBook]'s own memory file for this project predates today; this primer supersedes it. Read this, then reconcile `project_geol333_cruise_walk.md` on the MacBook against it.

## Pull these before starting

```
git -C ~/repos/claude-config pull
git -C ~/repos/class_dev/geol-333-fall-2026 pull     # branch restructure-rebalance-2026-06-21, NOT main
git -C ~/repos/class_dev/geol-333-714 pull           # public student repo, main
```

Build repo HEAD at writing: `645e5ed` or later (the Wk 4-5 problems integration proposal may have landed after; check `git log -1`). Public repo at `ff070e1`. 42 tests pass. Working trees clean.

## Two [iMac]-local things that did not travel

1. **Permissions allowlist.** `~/.claude/settings.json` is not tracked. Re-add this block on the MacBook (Dax's ruling 2026-08-28: trivial prompts bury consequential ones; see the feedback rule below):
   ```json
   "allow": [
     "Bash(git add *)", "Bash(git commit *)",
     "Bash(uv run pytest)", "Bash(uv run pytest *)",
     "Bash(uv run ruff check *)", "Bash(uv run ruff format *)",
     "Bash(ruff check *)", "Bash(ruff format *)",
     "Bash(mkdir *)", "Bash(lsof *)", "Bash(uname *)",
     "Edit(~/repos/**)", "Write(~/repos/**)",
     "Edit(~/.claude/projects/**)", "Write(~/.claude/projects/**)",
     "WebSearch"
   ]
   ```
   Push, rm, mv, git reset, Dropbox, Azure, `open`, WebFetch and interpreter calls still prompt, on purpose.
2. **The Burger photographs** (`literature/print_photos/burger_ch6/`, gitignored, 165 frames) exist only on the [iMac]. Everything read from them is in the tracked inventory. Any re-shoot must be uploaded to whichever machine runs the reading agent.

## Feedback rules added today (write them to MacBook memory)

- **Approval fatigue is a safety failure** (Dax, 2026-08-28). Keep the allowlist current; prompts are for push, delete, Dropbox, external sends. Rulings that are his are batched into one decision sheet per phase (AskUserQuestion, up to four questions), never a drip of single questions. Decide obvious things and say what was decided. Refines the one-question-per-turn rule, which was about clarity.
- **Concurrent agents commit with `git commit --only <paths>`.** A bare `git commit` after staging commits the whole index; one agent swept another's staged files today and self-repaired with `reset --soft`.

## Rulings made today, all implemented and pushed

| Ruling | Where it landed |
|---|---|
| D2/D3 notation: Burger's `R` and `l` everywhere students see the anchor equation; Python identifiers stay `L` | `475df4f`, `16281fc`, `645e5ed` (repo-wide, including exams, rubrics, notebooks, template, a missed live handout `trig_identities_card.md`) |
| F8/D1 fit form: fitted intercept, g from the slope, intercept is a diagnostic | `38f0e7f` (Wk 1 Block 8, Wk 2, HW0) |
| Wk 1 clock: 160 in 150 accepted; `K = l + ε` algebra second in the shed order | `walk_notes.md` rulings table |
| A2b: drop count removed, "several of the lowest" | `start_here.md:23`, `syllabus_page.md:35` (the syllabi never had it; removed `527455c` 2026-07-15) |
| Syllabus PDFs tagged PDF/UA-1 (WeasyPrint 66), `§` schedule form, `§6.7.1` on the Sep 23 row | `b00bf03`; staged in `outputs/syllabus_staging/`, verified with pypdf |
| Citation audit rows 10-14 dispositioned | `c93da14` |
| JP1 list for Sep 2: two open papers (Abbott & Louie 2000 via NBMG, Mendez et al. 2016 via USGS), seven pending library | `830127e` |
| Burger problems enter via board work, Daily Inquiry catalysts, HW notebooks, exams; no syllabus or Wave 1 page change | `records/shell_punchlist_2026_08_28.md` status section |
| Burger problems ethics (extension of 08-27): inventory keeps a structured index, never verbatim; assigned problems may be quoted with citation on Brightspace assignment pages and exams (closed, students own the text); never in the public repo or Colab notebooks (cite by number). Lillie problems not reproducible; re-authored setups fine | `literature/README.md` Burger row, `0835f05` |
| Waves plan: per-page one-paste rule; Wave 1 pastes 2026-08-28 | `4aa64de` |

## Library, settled

Alida (QC Library, 2026-08-28): QC owns neither *Geophysics* nor JEEG. Butler 1984 is open access via Google Scholar. The other six she has as PDFs and is posting on a **password-protected library course page**; link and password to Dax today or soon. Dax's own proxy test confirmed no GSW license ("You do not have access to this content"). **The password goes into Brightspace only, never into any repo.** Mina Rees not needed. When the link arrives: one JP1 sitting (`assignment_jp1`, its three companions, and the `jp1_paper_list` topic Dax creates and maps).

## The Wave 1 sitting (Dax runs it; Claude never operates in the shells)

Commands, verbatim, in `docs/lesson_plans/records/shell_punchlist_2026_08_28.md:133-151`: 11 topics per shell via the pusher (`uv run python` prefix mandatory, never `--all`), hand-pastes from `outputs/paste_sheets/geol{714,333}_descriptions.html`, Dropbox overwrite in place of 9 handout PDFs (`outputs/handouts/`) and 2 syllabus PDFs (`outputs/syllabus_staging/`). HW0, HW1 and `week_02_lsq` are already republished to the public repo; drift is zero except `pendulum_inclass.csv`, expected until Wk 2.

If the pusher reports anything other than 11 updated topics per shell, he pastes structure-only output (topic names and URLs). FERPA boundary unchanged: nothing from Classlist, Grades, submissions.

## Burger Ch. 6 inventory (`docs/lesson_plans/burger_ch6_inventory.md`, 1064+ lines)

Complete through §6.8: Eqs. 6.1-6.58 no gap, Tables 6.1-6.10, Figs. 6.1-6.39, 155 unique frames IMG_2273-2428 plus problems frames 2434-2443. Week 4's depth rule is in verbatim (Eq. 6.54 sphere `z = 1.305 x½`, Eq. 6.55 cylinder `z = x½`, Burger's 496 m check against Table 6.6's 500 m). Divergence register has D10 (`φ` is fault inclination in Eq. 6.48 and latitude in Eqs. 6.11-6.28). T&S map gained six rows; T&S 5.106 moves to Wk 5.

**Problems 6.7-6.14 indexed** (Problems section, with a by-week table: 6.7, 6.9, 6.10, 6.13 assignable by Wk 4's reading; all eight by Wk 5). **Still owed to the camera**, ranked in `records/burger_ch6_shot_list_2026_08_28.md`: Problems 6.1-6.6 (frames 2429-2433 never arrived; check the camera roll), the page after 6.14 (set may continue), Figure 6.33 body (Problem 6.14 needs it), Figure 6.34 axis, and eleven small crops.

## Design direction set at the end of the day (Dax, 2026-08-28)

"We can build the runsheets around the problems we choose, and it is very important to prioritize the portions of the chapter we cover. Certainly we will skip many sections." Problem-first, coverage-triaged runsheets for Wks 3-5. The delivered syllabus reading rows stay fixed; what is covered in the room is a subset, so skipping sections changes no delivered document. Two Opus proposals were dispatched at handoff time and may or may not have landed (check `git log` on the build repo):
- `records/burger_problems_integration_wk4_wk5_2026_08_28.md`: placement of Problems 6.7-6.14 into the existing Wk 4-5 blocks (section-first; useful as an inventory of fit).
- `records/burger_coverage_priority_wk3_wk5_2026_08_28.md`: every subsection §6.1.1-§6.8.3 triaged COVER / READ ONLY / SKIP against the LO map and the HW/exam chain; anchor problems per meeting; what the A3 drafts lose; assessment chain per anchor. This is the one that matches his direction.

## Next Claude work, in order

1. Read both proposals if they landed; walk the coverage-priority one with him, one decision sheet per meeting (Wk 3, Wk 4, Wk 5), then rebuild the A3 runsheets backward from the chosen anchors.
2. Week 2 walk (Wave 2, `page_wk2` pastes before Sep 9). Two items pre-loaded at `records/morning_punchlist_2026_08_27.md:111`.
3. When Problems 6.1-6.6 arrive: index them (same rule), then the Wk 2-3 integration.
4. Weeks 3-5 walk (Wave 3, before Sep 16): 14 `WALK:` markers in the A3 drafts; Burger has three elevation corrections, not two.

## Still his, not delegable

F5 (Block 2 slope drawing, cold: Eq. 6.17 settles the physics as `cos θ`; the runsheet's drawing instruction yields sine). 333 group formation at Block 9 Beat 2 (proposal: pre-assign from the roster). The duplicate 714 topic `42016075`.
