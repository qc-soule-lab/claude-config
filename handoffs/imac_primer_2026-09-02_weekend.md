*AI-generated draft (Claude, Anthropic), for review. Written on the MacBook after both Sep 2 meetings, handing to the iMac for the weekend.*

# Handoff to the iMac, weekend of 2026-09-05

**Both courses met on Wed Sep 2.** GEOL 16 meeting 2 in the morning, GEOL 333/714 meeting 1 at 4:35. He is on the iMac for the weekend.

Everything is pushed and clean: `geol-333-fall-2026` `9cc93bf`, `geol-333-714` `54c4d64`, `geol-16-fall-2026` `e740c86`, `claude-config` tip is this file's commit.

## Two things with dates on them

1. **Thursday Sep 3: the JP1 curated paper list AND the named round assignments.** Both were promised out loud in last night's Block 9 pitch and both are written on the Panel D ledger. The list needs citation verification, then it posts as a Brightspace page on the Journal Presentation 1 page, which then takes one re-paste. The named assignments need the alphabetical split computed from the final roster. Neither existed at class time; the runsheet names Thursday for both so the room heard one date rather than two.
2. **Sep 9, the Wk 2 collection: the pendulum length.** See below. This is the real deadline for it.

## The pendulum is 1.0127 m and three artifacts say 1.000

Recorded in full in `PUNCHLIST.md` under the ruler heading. Short version: `l` is pivot to the centre of the mass, the apparatus hangs with pivot-to-top at 1.000 m, and the one-inch bob adds its 1.27 cm radius.

**Timing the real pendulum and computing `g` with `l` = 1.000 gives 9.687, which is 1.25% low. HW0 lands 9.66, 1.53% low, and tells students that is an ordinary noise draw.** A length-convention error of that size is a systematic of the same magnitude and the same sign, so left alone the course teaches a bias as scatter.

The Wk 2 marking spec already has the right convention and disagrees with the apparatus: mark at `l − 1.27 cm`, so a 1.000 m length is marked at 98.7 cm, not 100 cm.

**The open question is his:** re-mark the apparatus to 98.7 cm so `l` really is 1.000 and the documents stand, or move the documents to 1.0127. The second is arguably the better lesson, since the correction becomes a live example of a hidden assumption biasing a result by more than the scatter. Three artifacts assume 1.000, two of them published: `lecture_01_onramp.ipynb` section 3, `HW0_pendulum.ipynb` and its 9.811 self-check, and the Wk 1 runsheet Block 7 DRIVE.

## Owed: the record of the class as taught

**Not written, and only he has the facts.** The GEOL 16 meeting 1 pattern applies: what the room reached, what dropped, and what carries into Wk 2. Specific things worth capturing while they are fresh:

- how far the evening got, and which blocks were shed
- whether the Block 5 two-list timing conditional fired, and what the two spreads were
- whether the Block 1 Beat 1 subsurface round worked, since the whole opener was rebuilt around it hours before delivery
- whether the rock landed as a mechanic, and **where it stopped**, because that is where Block 2 resumes next week and the note carrying that fact was deleted twice yesterday and is recorded nowhere
- the Block 1 Beat 1 timing, still unstated in the runsheet
- whether the in-class CSV matched the still-open schema decision, deadline the Sep 9 meeting

## What changed on 333/714 on Sep 2, seven commits

The Wk 1 runsheet was substantially rebuilt on the morning of the meeting.

- **Block 1 Beat 1 became a board build.** The opener was "What is geophysics?" asked cold, with the delivered learning outcomes read out thirty seconds later. It is now the room saying what it would want to know about ground it cannot dig into, drawn onto a cross-section on Panel C, with the physical properties building on A3. The outcomes list moved to Beat 3.
- **The second half teaches potential fields against impedance contrast**, elicited. Acoustic and electromagnetic impedance are distinguished, conductivity and permittivity are separated with a reference table of the targets the room names, and the close is that two methods agreeing beats one method certain.
- **The rock moved from Block 2 to Beat 1**, with his own wording, and every question is marked ROCK or HANDS under one rule: rock for "give me one thing", hands for "commit to an answer".
- **He walked the reading copy and cut the entire instructor-note layer from Block 1**, eight items. Three orphaned facts went to `PUNCHLIST.md`.
- **Block 2's three ASKs became actual questions.** They had said "the room directs" without giving him anything to ask.
- **The identity is now derived**, three lines: Pythagoras on a 3-4-5 triangle divided through by 25.
- **Block 4's think-pair-share catalyst is gone.** It asked what the equation assumes, which only someone who knows the answer can answer, and it duplicated the PROMPT above it. The rock now goes round on "that is the Earth this equation believes in, tell me one way it is a lie", with a listen-for table mapping answers to rows. One catalyst remains in the evening, the ungraded opener.
- **Two correctness fixes**: the exam-materials line no longer forbids the calculator the exam requires, and the JP1 pitch no longer claims assignments are already posted.

## What changed on GEOL 16

Meeting 2 was taught and **reached slide 19 of 39**. `scripts/deck/build_mtg02_as_taught.py` splits the deck: `class_02_slides.pptx` is slides 1 to 19 plus a Key terms slide trimmed to the six terms the room actually met, and `geo16_f26_mtg03.pptx` is slides 20 to 39 as the Sep 9 seed. EX 02 ran even though its slide never went up.

**Still manual and not done: open `class_02_slides.pptx`, Save As PDF, and put only the PDF in the shared `Geol16_lectureSlidesF2026` folder.** That folder is a public link, so the .pptx must not go there.

**The meeting 3 seed is a seed, not a deck.** No front matter, its objectives and key-terms slides still say Class 2, and its last slide still says Exit Slip Class 1 carrying the `ex02` password. EX 03 is Sep 9.

## Open queue, nothing blocking

1. **The fuller exam description for Beat 3**, which he asked for and had not dictated when the day ended. Notes at `scratchpad/exams_description_notes.md`, including the ambiguity: Block 1 Beat 3 holds the policy table, Block 3 Beat 3 owns the assessment shape, and both Block 1 beats carry a "do not do here" pointing at Block 3. One of those has to change either way.
2. **Block 2 Beat 3 Stages 1 and 2** still have an unelicited ASK, the same defect fixed elsewhere in that block.
3. **The A3 pre-stage bullet**, which reoccupies a slot he cleared on 09-01. Unruled since yesterday morning.
4. **HW2 seven expressiveness items and HW5 nine.** MacBook-safe, and HW5 is the last copy carrying the old Colab-deletes banner.
5. **The syllabus re-delivery bundle** (iMac, WeasyPrint): the "AI policy below" pointer, the Wk-5-only JP1 language, the Oct 14 schedule row, one borderline sentence.
6. **The 333 Module 0 URL**: capture the id via right-click Inspect, then the map entry and rebuild are iMac work. Four plain-text mentions, cosmetic.
7. **`test_missing_links` skip on map-less machines**, proposed and unruled. The MacBook suite is red by default until then, 6 failed: 4 WeasyPrint plus 2 page-map.
8. **DRIVE-requires-SAY in `weekly_runsheet_template.md`**, Claude's promotion, still unruled from 09-01.
9. **MacBook WeasyPrint**, to be fixed after Sep 2 by his ruling. That date has now passed.

## Working practices set on Sep 2, worth carrying

- **A fresh versioned filename on every PDF build before opening it.** Reusing `outputs/handouts/runsheet.pdf` leaves Preview on the stale window and he correctly reports the change as missing. This cost real time.
- **Do not rebuild a PDF after every edit** during a working session.
- **When he walks a document top to bottom, log and do not apply** until he says. When he points at a line outside a walk, fix it.
- The reading copy is now a tracked artifact at `outputs/handouts/runsheet.pdf`, rebuilt whenever the runsheet changes.
