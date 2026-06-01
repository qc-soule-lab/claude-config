#!/usr/bin/env bash
# PreToolUse(Bash git commit) hook — block a commit whose STAGED diff contains a secret
# (Azure SAS URL, Anthropic/AWS key, or a private key). Runs in the repo working dir.
# Defends the "never commit credentials" rule, esp. Azure SAS URLs (bearer tokens).
set -euo pipefail
diff="$(git diff --cached --no-color 2>/dev/null || true)"
[ -z "$diff" ] && exit 0
hits="$(printf '%s' "$diff" | grep -nE \
  'sk-ant-[A-Za-z0-9_-]{8,}|[?&]sig=[A-Za-z0-9%]{12,}|blob\.core\.windows\.net[^[:space:]]*sig=|AZURE_BLOB_SAS_URL=.+|ANTHROPIC_API_KEY=[A-Za-z0-9]|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----' \
  | head -5 || true)"
if [ -n "$hits" ]; then
  # Redact captured signatures/keys so the hook itself never echoes the full secret.
  safe="$(printf '%s' "$hits" \
    | sed -E 's/(sig=[A-Za-z0-9%]{6})[A-Za-z0-9%]+/\1.../g; s/(sk-ant-[A-Za-z0-9_-]{6})[A-Za-z0-9_-]+/\1.../g')"
  {
    echo "BLOCKED: the staged diff appears to contain a secret (Azure SAS URL / API key / private key)."
    echo "A SAS URL is a bearer credential. Unstage and remove it before committing; then tell Dr. Soule so the credential can be rotated."
    echo "Matched (redacted):"
    printf '%s\n' "$safe"
  } >&2
  exit 2  # exit 2 = block the commit, feed the message back to Claude
fi
exit 0
