#!/usr/bin/env bash
# PreCompact hook — inject the lab's "summary contract" into every compaction
# (manual or auto), so the post-compaction summary preserves operational state.
# Compaction is lossy; this pins what must survive. Shell-only (no model call).
cat <<'JSON'
{"hookSpecificOutput": {"hookEventName": "PreCompact", "additionalContext": "LAB COMPACTION CONTRACT (injected by PreCompact hook) - the summary MUST explicitly preserve: (1) the current task and the exact next action; (2) every running background job: command, PID, log path, ETA, and its resume command; (3) uncommitted/unpushed state per repo touched this session; (4) open decisions awaiting the PI; (5) paths of files created or edited this session; (6) any credential-handling caveats (never the secrets themselves). FIRST ACTION AFTER COMPACTION: re-read the project MEMORY.md, reconcile it against this summary, and write anything the summary alone carries into memory immediately."}}
JSON
exit 0
