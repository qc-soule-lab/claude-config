*AI-generated draft (Claude, Anthropic), for review. The row facts are read from the repos; the state lines are the instructor's or Claude's report of that session.*

# Handoff index

**One place that says where the work was.** Sessions move between machines and between projects, and a fresh session in one project cannot see work done in another. This file is the only thing it has to read to find out.

## How to use it

**At session start:** read this file before assuming a project's state. If the newest row names a different project than the one you are in, say so rather than proceeding as though nothing happened elsewhere.

**Before ending a session:** append a row at the top of the table. Then commit and push **both** repos, this one and the project's. An unpushed index is worse than none, because it reads as "nothing happened".

**Where the detail note goes** depends on how far it reaches:

- **One project:** the project's own repo, next to the work. A record of a class as taught belongs beside the deck it describes.
- **More than one project, or aimed at a specific machine:** here in `handoffs/`, because it belongs to no single repo. `imac_primer_2026-08-31_geol16.md` is the pattern: written on the MacBook, addressed to the iMac, spanning GEOL 16 and GEOL 333.

Either way this file carries the pointer, not the content.

## Row format

| Field | Rule |
|---|---|
| Date | ISO, the date the session ended |
| Machine | iMac, MacBook, MacBookPro, Hub, DellPC (the tags in `CLAUDE.md`) |
| Project | Human name of the course or project |
| Landed at | `repo @ branch commit` plus **PUSHED** or **LOCAL** |
| State | One sentence. What is done, what is next |
| Detail | Repo-relative path to the full note, or none |

**`PUSHED` or `LOCAL` is the load-bearing field.** On 2026-08-31 a session on the iMac could not tell whether MacBook work existed and had not arrived, or had never happened. This field answers that in one glance, and `LOCAL` tells the next machine to go and fetch it rather than conclude nothing was done.

## Index, newest first

| Date | Machine | Project | Landed at | State | Detail |
|---|---|---|---|---|---|
| 2026-08-31 | MacBook | GEOL 16, GEOL 333 | `geol-16-fall-2026` @ `main` `d3f8b72` **PUSHED**, `claude-config` @ `main` `a3f0c59` **PUSHED** | Meeting 1 taught, room reached slide 17 of 24. Next decision is which of slides 18 to 24 carry into meeting 2, which settles the `EX 02` vocabulary question. Three deck defects diagnosed, none fixed. | `handoffs/imac_primer_2026-08-31_geol16.md`, and `geol-16-fall-2026` `docs/lesson_plans/records/class_01_taught_2026_08_31.md` |
| 2026-08-30 | iMac | GEOL 333 / 714 | `geol-333-fall-2026` @ `restructure-rebalance-2026-06-21` `b9ba246` **PUSHED** | Wk 1 runsheet walkthrough through Block 4 Beat 1. Syllabi rewritten and delivered. Resume at Block 4 Beat 2. | `docs/lesson_plans/records/handoff_macbook_2026_08_30.md` |

## Machine notes

Standing facts about a machine, as opposed to a session. Add here when a machine behaves differently from the others.

### MacBook: terminal text cannot be selected or copied

Reported 2026-08-31. Highlighting in the Claude Code terminal turns the selection green and neither Ctrl+C nor right click copies. The same text copies normally on the iMac.

**DIAGNOSED 2026-08-31 from the MacBook. The cause is mouse reporting: Terminal never makes a selection at all.**

Measured on that machine:

| Check | Value |
|---|---|
| `TERM_PROGRAM` | `Apple_Terminal`, version 453 |
| `TERM` | `xterm-256color` |
| `TMUX` | not set, and **no tmux process exists on the machine** |
| Terminal profile | `Basic`, with no custom `SelectionColor` |
| `AppleHighlightColor` | unset, so the system default **blue** |
| `CopyOnSelect` | not set |
| `pbcopy` | round-trip verified working |

**The green highlight is what settles it.** Terminal's Basic profile inherits the system highlight colour, which is blue on this machine. A green highlight is therefore not Terminal's text selection. It is Claude Code drawing its own, which means the drag is captured by the application and never reaches Terminal.app. No Terminal-level selection is created, so there is nothing for any copy key to take, which is also why right click's Copy does nothing.

That eliminates the other two candidates. **tmux is not installed or running**, so it cannot own the selection. And the wrong-key theory cannot explain either a green highlight or an empty right-click Copy, though Cmd+C rather than Ctrl+C is still the correct key on macOS once a real selection exists.

**The fix is to hold a modifier while dragging**, which suppresses mouse reporting for that drag. In Terminal.app the documented modifier is **Fn**. If Fn does not work, try **Shift**, which is the xterm convention some builds honour. In iTerm2 it is **Option**. This has not been confirmed by hand on the machine, so record which one works when you next try it.

**Two workarounds that need no modifier at all:**

- **Ask Claude to put it on the clipboard.** `printf '%s' '<text>' | pbcopy`, then Cmd+V anywhere. Verified working on this machine.
- **Ask Claude to write it to a file and open it.** Copying out of Preview or an editor is unaffected.

### MacBook: Dropbox files are online only, so large media reads as 0 bytes

Confirmed 2026-08-31 from the iMac. The MacBook reported all four copies of `msh_1980.mp4` at 0 bytes; on the iMac the same four are materialized at 58,815,590 bytes with no placeholder attribute.

**Nothing needs transferring between machines.** They are the same Dropbox files, and the MacBook simply has not downloaded them. The fix on that machine is to mark the file or its folder available offline, not to copy anything from the iMac.

**The teaching risk is the point.** A 0-byte media file on the machine at the podium means the room depends on the network. Meeting 1 streamed the video for this reason. Before teaching from the MacBook, pin the media the meeting needs.

This is the same mechanism as the 328 zero-byte files found in the GEOL 333 Dropbox audit on 2026-08-30: placeholders, not damage.

## Housekeeping

Keep roughly the last twenty rows. Move older ones to `handoffs/archive_YYYY.md` rather than deleting them, the same discipline as `MEMORY.md`.
