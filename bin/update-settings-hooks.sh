#!/usr/bin/env bash
# Idempotent: merge the lab's current hook registrations into an EXISTING
# ~/.claude/settings.json (which install.sh never overwrites, by design).
# Run after `git -C ~/repos/claude-config pull` to pick up new hooks.
# Adds only missing entries; never removes or reorders existing ones.
set -euo pipefail
python3 - <<'PY'
import json, os
home = os.path.expanduser("~")
path = f"{home}/.claude/settings.json"
s = json.load(open(path))
hooks = s.setdefault("hooks", {})
def ensure(event, matcher, script, timeout):
    entries = hooks.setdefault(event, [])
    entry = next((e for e in entries if e.get("matcher") == matcher), None)
    if entry is None:
        entry = {"matcher": matcher, "hooks": []}
        entries.append(entry)
    cmd = f"{home}/.claude/bin/{script}"
    if not any(script in h.get("command", "") for h in entry["hooks"]):
        entry["hooks"].append({"type": "command", "command": cmd, "timeout": timeout})
        print(f"  + {event}[{matcher}] -> {script}")
ensure("PreToolUse", "Bash(git commit:*)", "check-no-secrets-precommit.sh", 15)
ensure("PreToolUse", "Bash(git commit:*)", "pre-commit-gate.sh", 300)
ensure("PreCompact", "*", "precompact-summary-contract.sh", 5)
json.dump(s, open(path, "w"), indent=2); open(path, "a").write("\n")
print("settings.json hooks up to date (restart claude to activate)")
PY
