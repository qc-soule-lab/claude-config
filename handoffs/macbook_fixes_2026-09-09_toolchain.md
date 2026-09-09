*AI-generated draft (Claude, Anthropic), for review. Diagnoses were run on the MacBook 2026-09-09; the WeasyPrint one is verified by a successful render, the clipboard one is not yet confirmed by hand.*

# [MacBook] Two fixable toolchain problems: WeasyPrint and the clipboard

Both work on the iMac and neither works here. Raised 2026-09-09, to be fixed this
week, not before class.

---

## Problem 1: WeasyPrint cannot load `libgobject-2.0-0`

**The 2026-09-01 hypothesis was wrong.** The machine note in `README.md` says the
GTK/pango stack "macOS does not ship" is missing and "the likely fix is installing
the GTK stack via Homebrew." It is already installed:

```
/opt/homebrew/Cellar/glib     May 18 13:05
/opt/homebrew/Cellar/pango    May 18 13:05
/opt/homebrew/lib/libgobject-2.0.0.dylib
/opt/homebrew/lib/libpango-1.0.0.dylib
```

**The real cause is the loader path.** WeasyPrint opens these libraries through
cffi's `dlopen`, which searches the system paths and not Homebrew's. On Apple
Silicon Homebrew lives at `/opt/homebrew`, which is on no default search path, and
`DYLD_FALLBACK_LIBRARY_PATH` is unset in this shell. So the library is present,
findable by hand, and invisible to the process that wants it.

**Verified fix, run on this machine 2026-09-09:**

```
DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib uv run python -c \
  "import weasyprint; weasyprint.HTML(string='<h1>probe</h1>').write_pdf('/tmp/probe.pdf')"
→ WEASYPRINT RENDER OK, 2830 bytes
```

### Plan

1. **Add the export to the shell profile in `~/repos/dotfiles`** rather than to
   one project, because the problem belongs to the machine and hits every repo:
   `export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib`. Nothing in dotfiles
   sets any `DYLD_*` variable today, so this adds rather than overrides.
2. **Verify in a fresh shell** with the probe above.
3. **Re-run the four PDF builds that were blocked here**, then look at each
   rendered page rather than trusting exit status: both GEOL 333 syllabus PDFs,
   `outputs/instructor_packs/week_01/timing_card.pdf`, and GEOL 16's
   `build_opening_quiz.py`.
4. **Re-run the GEOL 333 test suite.** Four of its failures on this machine are
   WeasyPrint import errors, and the expected result is `63 passed` rather than
   `4 failed, 59 passed`. If those four now pass, the machine-specific test
   caveat in `README.md` can be deleted.
5. **Correct the machine note** in `handoffs/README.md`: the stack is installed,
   the cause is the loader path, and the fix is one export.

**Risk is low and reversible.** `DYLD_FALLBACK_LIBRARY_PATH` is a fallback, so it
is consulted only after the normal search fails, and removing the line restores
today's behavior exactly. It is worth knowing that macOS strips `DYLD_*` from the
environment of system binaries under System Integrity Protection, so a tool
launched by launchd or by a system Python may still not see it. Homebrew Python
and `uv` are unaffected, which is what these builds use.

**Then decide what to do about `build_catalyst_sheet.py`**, which was written
against headless Chrome on 2026-09-09 specifically to route around this. It works
and needs no Homebrew stack at all, so the options are to keep it as the one
Chrome-rendered builder, or to port it to WeasyPrint for consistency with the
other eleven. My recommendation is to keep it: it is the only PDF builder in
either course that runs on a machine with no GTK stack, which is worth having.

---

## Problem 2: dragging to select in Claude Code copies nothing

**What is already known** (diagnosed 2026-09-01, recorded in `README.md`): the
drag paints a green highlight, Terminal's own selection colour on this machine is
blue, and right-click Copy is empty. So Claude Code is drawing its own selection
and consuming the mouse events; Terminal never creates a selection, and there is
nothing for any copy key to take. tmux is not installed, so it is not involved.

**What this machine reports:** `TERM_PROGRAM=Apple_Terminal`,
`TERM=xterm-256color`, Claude Code `2.1.231`. Neither `claude --help` nor
`~/.claude/settings.json` exposes a mouse or selection setting, so there is
nothing to switch off from the config side that I can see.

**The unexplained part is why the iMac is fine**, and that is the fastest thing to
settle, because it converts guesswork into a difference.

### Plan

1. **On the iMac, run three commands and write the answers here**:
   `echo $TERM_PROGRAM`, `claude --version`, and `defaults read com.apple.Terminal`
   piped to grep for the profile name. If the iMac is on iTerm2, or on an older
   Claude Code, the difference is explained and the fix follows from it.
2. **On this machine, try the modifier drags in order**, thirty seconds each:
   **Fn+drag** (Terminal.app's documented modifier for suppressing mouse
   reporting), then **Shift+drag** (the xterm convention some builds honour), then
   **Option+drag**. Record which one produces a blue highlight rather than green.
   A blue highlight means Terminal owns the selection and Cmd+C will work.
3. **If a modifier works**, that is the answer: write it into the machine note and
   stop. No configuration change is needed.
4. **If none works**, the remaining candidates in order of cost:
   - Install **iTerm2** and run Claude Code there. Option+drag is its documented
     override, and it is the terminal the lab already trusts elsewhere.
   - Check `/config` inside Claude Code for a mouse or selection toggle that the
     CLI help does not list.
   - Check whether `~/.claude/keybindings.json` can rebind a copy action, which
     the `keybindings-help` skill covers.
   - Ask the `claude-code-guide` agent, which is the right tool for "does this
     version have a setting for X" and which I did not use today because the
     session's standing instruction is not to spawn agents unasked.
5. **Record the outcome in the machine note either way.** A confirmed modifier is
   worth as much as a fix, and the current note says the modifier "has not been
   confirmed by hand," which is what keeps this open.

**The two workarounds stand and neither needs a fix.** Ask Claude to put text on
the clipboard with `pbcopy`, which is verified working here and is how every
Brightspace paste has gone out today; or have Claude write the text to a file and
open it, since copying out of Preview or an editor is unaffected.

---

## Sequencing

Problem 1 is a one-line change with a verified fix and a five-minute
verification, so it goes first. Problem 2 needs the iMac comparison before any
change is worth making, so its first step happens the next time that machine is
in front of you.
