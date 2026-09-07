#!/usr/bin/env python3
"""Exercise the copilot-firewall Bash hook against synthetic payloads.

The hook cannot be tested from a Bash command line: any command containing a
protected path is blocked before it runs, including the test itself. So the
payloads live here and this script feeds them to the hook as a subprocess.

Write this file with the Write tool, never a Bash heredoc: a heredoc whose body
contains a protected name is itself blocked by guard 1.
"""

from __future__ import annotations

import json
import os
import subprocess

HOOK = os.path.expanduser("~/.claude/bin/copilot-firewall-bash.sh")
HOME = os.path.realpath(os.path.expanduser("~"))
DBX = f"{HOME}/Queens College Dropbox"
ACCT = f"{DBX}/Dax Soule"

# (label, command, expect_denied, expect_category_substring)
CASES = [
    # --- Guard 2: broad searches rooted above protected trees ---------------
    (
        "the actual 2026-09-07 leak, escaped spaces",
        r'find ~/Queens\ College\ Dropbox -iname "*offer*letter*"',
        True,
        "recursive search",
    ),
    ("find rooted at bare ~", 'find ~ -name "*.pdf"', True, "recursive search"),
    ("find rooted at bare $HOME", 'find $HOME -name "*.pdf"', True, "recursive search"),
    (
        "find rooted at absolute home",
        f'find {HOME} -name "*.pdf"',
        True,
        "recursive search",
    ),
    ("quoted Dropbox root", f'find "{DBX}" -iname "*.pdf"', True, "recursive search"),
    ("account folder, depth 2", f'grep -r needle "{ACCT}"', True, "recursive search"),
    (
        "QueensCollege, depth 4, the ancestor of the personnel tree",
        f'find "{ACCT}/AllFiles/QueensCollege" -name "*.pdf"',
        True,
        "recursive search",
    ),
    ("rg rooted at the Dropbox root", f'rg -n needle "{DBX}"', True, "recursive search"),
    # --- Guard 2 must NOT fire on legitimately narrow searches --------------
    (
        "depth 5 is below the personnel tree, allowed",
        f'find "{ACCT}/AllFiles/QueensCollege/Research" -name "*.pdf"',
        False,
        "",
    ),
    (
        "the expenses tree this session works in",
        f'find "{ACCT}/AllFiles/QueensCollege/Research/Expenses/OverheadAccount/OH_2026" -type f',
        False,
        "",
    ),
    ("a repo outside Dropbox", 'find ~/repos/report_dev -name "*.py"', False, ""),
    ("non-recursive ls of the Dropbox root", f'ls "{DBX}"', False, ""),
    ("plain grep, no -r", f'grep needle "{DBX}/notes.txt"', False, ""),
    (
        "broad sweep with an explicit prune is deliberate narrowing",
        f'find "{DBX}" -path "*/private/*" -prune -o -name "*.pdf" -print',
        False,
        "",
    ),
    (
        "broad sweep with --exclude-dir",
        f'grep -r needle "{DBX}" --exclude-dir=private',
        False,
        "",
    ),
    ("unrelated command", "git status", False, ""),
    # --- A heredoc body is data, not a command -----------------------------
    #
    # Regression for 2026-09-07: this hook blocked its own commit, because the
    # message quoted the broad find command it had just started denying.
    (
        "a commit message quoting a broad search is not a search",
        'git commit -F - <<\'MSG\'\nGuard broad searches\n\nThis ran cleanly:\n\n    find ~/Queens\\ College\\ Dropbox -iname "*offer*letter*"\n\nand leaked its output.\nMSG',
        False,
        "",
    ),
    (
        "an unterminated heredoc still denies a real search after it",
        f'cat <<\'EOF\'\nnotes\nEOF\nfind "{DBX}" -name "*.pdf"',
        True,
        "recursive search",
    ),
    # --- Guard 1: commands that name a protected path -----------------------
    (
        "own personnel file, the original category",
        f'cat "{ACCT}/AllFiles/QueensCollege/EmployeeInfo/TenureFile/x.pdf"',
        True,
        "personnel material",
    ),
    (
        "another person's committee folder",
        f'ls "{ACCT}/SEES P&B committee"',
        True,
        "another person",
    ),
    (
        "a nested Promotion Folder",
        f'cat "{ACCT}/SEES P&B Promotion Folder/Diane Promotion folder/cv.pdf"',
        True,
        "another person",
    ),
    (
        "reappointments directory",
        f'ls "{ACCT}/SEES reappointments 2020-2021"',
        True,
        "another person",
    ),
    (
        "student accommodations",
        f'ls "{HOME}/course/accommodations/"',
        True,
        "student records",
    ),
    (
        "final grades",
        f'cat "{HOME}/course/finalGrades/grades.csv"',
        True,
        "student records",
    ),
    (
        "copilot-only material still denied",
        f'cat "{HOME}/x/_NONPUBLIC_copilot_only/quote.pdf"',
        True,
        "non-public",
    ),
    (
        "embargoed material still denied",
        f'ls "{HOME}/x/_EMBARGOED_do_not_access/"',
        True,
        "embargoed",
    ),
    # --- Guard 1 must not fire on prose that merely names the categories ----
    #
    # The 2026-08-02 note records the same mistake: matching bare words blocked
    # a commit message that only described the protected directories. Both new
    # branches are slash-anchored for this reason.
    (
        "prose naming the new categories, no slashes",
        'echo "categories: SEES P&B committee, Promotion Folder, reappointments"',
        False,
        "",
    ),
    (
        "prose naming accommodations and grades, no slashes",
        'echo "never paste accommodations or finalGrades into a conversation"',
        False,
        "",
    ),
    (
        "prose naming the original categories, no slashes",
        'echo "EmployeeInfo and TenureFile hold personnel material"',
        False,
        "",
    ),
]


def run(command: str) -> tuple[bool, str]:
    """Feed one command to the hook. Returns (denied, reason)."""
    payload = json.dumps({"tool_name": "Bash", "tool_input": {"command": command}})
    proc = subprocess.run(
        [HOOK], input=payload, capture_output=True, text=True, timeout=30
    )
    out = proc.stdout.strip()
    if not out:
        return False, ""
    try:
        parsed = json.loads(out)
    except json.JSONDecodeError:
        return False, f"UNPARSEABLE OUTPUT: {out[:200]}"
    hso = parsed.get("hookSpecificOutput", {})
    return hso.get("permissionDecision") == "deny", hso.get(
        "permissionDecisionReason", ""
    )


def main() -> int:
    failures = 0
    for label, command, expect_denied, expect_cat in CASES:
        denied, reason = run(command)
        ok = denied == expect_denied
        if ok and expect_denied and expect_cat:
            ok = expect_cat.lower() in reason.lower()
        if not ok:
            failures += 1
        want = "deny" if expect_denied else "allow"
        got = "deny" if denied else "allow"
        print(f"  {'PASS' if ok else 'FAIL'}  want={want:<5} got={got:<5}  {label}")
        if not ok:
            print(f"        command: {command[:160]}")
            print(f"        reason : {reason[:240]}")

    print(f"\n  {len(CASES) - failures}/{len(CASES)} passed")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
