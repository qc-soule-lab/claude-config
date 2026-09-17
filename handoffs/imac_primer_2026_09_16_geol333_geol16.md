*AI-generated draft (Claude, Anthropic), for review. Written on the MacBook on the evening of 2026-09-16 as he moved to the iMac. Spans GEOL 333 / 714 Week 3 and GEOL 16 meeting 5, so it lives here rather than in either repo. Every repo fact below was read from the repos; the teaching facts are his same-day reports.*

# iMac primer, 2026-09-16: Week 3 was taught from v21, meeting 5 stopped at 21, and a vocabulary job is half done

## Read this first

- **Nothing is unpushed.** `geol-333-fall-2026` @ `restructure-rebalance-2026-06-21` `f426f46`, `geol-16-fall-2026` @ `main` `94ac18d`, `claude-config` @ `main`, all PUSHED from the MacBook. Pull all three before doing anything.
- **Another MacBook session ran today on `student-onramp`** (index row above this one's date, PR #11 into `001-coding-onramp-v1` OPEN). It is unrelated to the course work and Hub-only; do not clone it on the iMac.
- **Dropbox lagged this morning.** At 22:24 the Week 03 folder had 6 files and at 22:27 it had 23. When a folder looks short, wait a minute and re-check the MANIFEST checksums before concluding anything was lost.
- **HW1 posts Thursday Sep 17**, tomorrow, and nothing about it is in front of a student. PUNCHLIST C1 and C4, his hands: hand-verify `HW1_stairwell.ipynb`, Q6.1's rewrite unconfirmed, then release. `test_public_notebooks_are_not_stale` is red on purpose until then.

## GEOL 333 / 714, Week 3 (taught Wed Sep 16 from v21)

**He walked v19 himself, section by section, asking questions; each question that exposed a gap became a deferred finding.** D1 to D14 in `docs/lesson_plans/records/wk3_walk_2026_09_16.md`, every one with its options and a no-change option, every ruling dated. His stated method, now twice confirmed: one finding at a time, as a question with concrete options, one of which is always no change. **Do not sweep pages.**

| Version | Pages | What went in |
|---|---|---|
| v20 | 30 | D12 (Eq. 6.14 bullet, 6.1 intro), D13 (Eq. 6.24 slab-from-one-sheet bullet, the two-ways-to-see-it bullet, and the derivation as the last block of the appendix), D14 (Eq. 6.30 ring note for his eyes at 6.2 ask 4) |
| v21 | 31 | D1 (§4 dashed line named as the base station's elevation, spoken), D2 (one line on dial divisions and the dial constant before the 6.3 problem), D5 (give-it-back rescue at item 3), D6 (spring, temperature, Moon at item 1), D10 (either order at item 4), D11 (sign convention in 6.1 ask 4) |

No change by his ruling: D3, D4, D7, D8, D9. Pages 1 to 9 untouched throughout. The Dropbox Week 03 manifest points at v21 and at the **20-sheet exit slip** (40 pp, rebuilt on his instruction; codes fresh, the 25-sheet run is void). Both were open in Preview when he left for class, so **v21 and the 20-sheet slip are what he printed and taught from.**

**Two corrections from the walk worth keeping.** He tried Eq. 6.30 with R_o = 0 and R_i = 450 and got the disk with its sign flipped; the note at ask 4 now walks the limit R_o → ∞ so the last root's z visibly cancels. And the 5 mGal escarpment is right (2D half-plane, 5.33), the 8 (half ring) is wrong, per the Sep 15 correction; the note carries both numbers.

**No as-taught record exists for Week 3.** He said "lessons are over" and nothing else. First question on the iMac: what section did the room reach, did the exit slip and both catalysts run, and did §8 (HW1, provisional) run. Write `records/wk3_as_taught_2026_09_16.md` beside the Week 2 one.

### The vocabulary job, half done

His instruction: identify the important vocabulary introduced this week and make sure each term is linked on the week page to the glossary or a vetted online resource.

**What is established:**

- `scripts/build_brightspace_html.py` wires **every bolded term the glossary knows** to its entry anchor (rulings 22 and 23, 2026-09-04). So the job is: add entries to `docs/brightspace/glossary.md` (HTML `<h3 id="slug">` headings plus the jump index at the top), add plural or alternate surface forms to `_GLOSSARY_EXTRA_FORMS` in the builder, bold the terms on `docs/brightspace/page_wk3.md`, rebuild, and he re-pastes the page and the glossary into both shells.
- **Glossary entries that exist:** anomaly, base station, drift, equivalence principle, free-air gradient, gravimeter, milligal, Newton's law, potential field, relative and absolute measurement, shell theorem, station, survey loop, tidal effect, random error, and the Week 1 and 2 statistics terms.
- **Week 3 terms with no entry:** datum (already bolded on `page_wk2` with nothing to link to), free-air correction, Bouguer correction (with infinite slab as a form), terrain correction, latitude correction, reduction density, Bouguer anomaly, dial constant (with dial division as a form), Hooke's law (with spring constant and restoring force as forms), the set of gravity corrections, and elasticity, which he asked for a geophysics definition of. The drafted elasticity entry is at the bottom of this note.
- **Vetted resource, verified today:** UBC-GIF's *Geophysics for Practicing Geoscientists*, `https://gpg.geosci.xyz`, footer licence **CC BY 4.0**. `content/gravity/gravity_data.html#corrections` covers drift, tides, latitude (0.811 sin 2φ mGal/km), free-air (0.3086h), Bouguer (0.04191 h d, the older G), terrain, and Bouguer anomaly under `#data-presentation-options`; `#field-procedures` covers base station looping and the dial constant. `content/gravity/gravity_basics.html` covers Hooke's law and the milligal. It does not treat datum, drift as a section, or the free-air gradient. **Pattern to follow is ruling 36:** paraphrase in the course's words, cite with a link, never copy.
- **SEG Wiki returns 403 to automated fetch.** Not used; if he wants Sheriff's dictionary linked he vets it by hand.
- **He has not vetted the GPG pages himself.** The reading-announcement rule (ruling 20) says nothing fires until everything it points to is vetted. Show him one GPG page before any link goes live.

**Also live and false:** `page_wk3` and `page_wk2` still tell students things that are false since the restructure (from the Sep 15 note). The vocabulary edit to `page_wk3` is a chance to fix that page in the same paste; ask him whether to fold it in.

### Still his

- Audio to the phone: no route chosen. The MP3s and m4b are in Dropbox Week 03 and now on the MacBook too; Finder sync is available from either Mac.
- The podcast is a [iMac]-rendered artifact (`say` voices Lee, Tom, Ava); the MacBook has not been checked for those voices.
- The Burger 6.3-before-6.1 ordering question from the Sep 15 note, unruled.

## GEOL 16, meeting 5 (taught Wed Sep 16, reached slide 21 of 36)

`scripts/deck/build_mtg05_as_taught.py` did the split without writing to the deck he had open in PowerPoint. Record: `docs/lesson_plans/records/class_05_taught_2026_09_16.md`. PUNCHLIST rows 28 to 30 are the open items.

| File | Where | State |
|---|---|---|
| `class_05_slides.pptx`, 22 slides | `Meeting 05 - mid-ocean ridges/` | **not posted**; slide 4's news placeholder is unfilled in the saved deck (he may have filled it in the room without saving: save, then `--posted-only`); `meeting_05_sources.md` does not exist so the licence gate cannot run; MacDonald 1982 and Karson 2002 figures on slides 16 and 19 |
| `geo16_f26_mtg06.pptx`, 15 slides | `Meeting 06 - submarine volcanism/` (new) | slides 22 to 36 whole; needs front matter and Class 6 footers; **slide 36 is a picture fill** (image19.png), not blank; nobody has rendered it |
| `geo16_f26_mtg06_magnetics_seed.pptx`, 10 slides | moved to `Meeting 06 - submarine volcanism/` | his 2026-09-14 ruling |

**Meeting 6 is Wed Sep 23 and inherits 25 carried slides before any submarine volcanism exists.** That needs his ruling on what fits, then a `build_mtg06.py` in the meeting 5 builder's pattern (copy whole, prune, clone footers).

**Four key terms are on the posted Class 5 slide on figure evidence only:** pillow basalt, sheeted dikes, bathymetry, seafloor spreading. If any was not said in the room, `DROP_TERMS` in the script takes it and `--posted-only` rebuilds. Cut already: spreading rate, hydrothermal circulation, axial magma chamber.

Also in that Dropbox folder: nine `.pre_*` backup copies of the meeting 5 pptx, about 10 MB each, from the iMac build. Unruled.

## MacBook machine note added today

Claude's Bash tool runs a non-login shell, so the `DYLD_FALLBACK_LIBRARY_PATH` export installed on Sep 13 is not seen there and WeasyPrint fails at test collection. `DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib uv run pytest -q` works. Recorded under Machine notes in the index.

## Drafted elasticity entry, not yet in the glossary

His request 2026-09-16: "I want a geo definition of elasticity." Slots between drift and equivalence principle.

> **elasticity.** The property of a material that deforms under an applied force and returns to its original shape when the force is removed. For small deformations the strain is proportional to the stress, which is Hooke's law: double the load and the stretch doubles, remove the load and the stretch goes to zero. The constants of proportionality are the elastic moduli: Young's modulus for stretching, the bulk modulus for squeezing, the shear modulus for twisting. Rock is elastic at the strains a seismic wave carries, and those moduli with density set the wave's speed. The gravimeter spring is elastic in the same sense: its restoring force is proportional to its extension, so a change in gravity becomes a change in length the dial measures. Drift is where the spring falls short of perfect elasticity: held under load for hours it creeps, and the reading walks while gravity has not changed.
