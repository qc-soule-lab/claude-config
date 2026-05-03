#!/usr/bin/env bash
# PreToolUse hook for WebFetch: if the URL is a known publisher or DOI-resolver
# domain, inject an ethical-check reminder before the fetch proceeds.
#
# Safety-net for the ethical-check skill — the skill should trigger on its own
# via description matching, but this hook guarantees Claude sees the warning
# before fetching from a paywalled source.
#
# Exits 0 silently for non-publisher URLs (no injection, no gate).

set -euo pipefail

payload=$(cat)

url=$(printf '%s' "$payload" | python3 -c 'import json, sys
try:
    p = json.load(sys.stdin)
    print(p.get("tool_input", {}).get("url", ""))
except Exception:
    pass')

[ -z "${url:-}" ] && exit 0

# Match against publisher, DOI resolver, and major-journal domains.
# Hits: commercial publishers, DOI resolvers, faculty course-material hosts.
case "$url" in
    *sciencedirect.com*|*elsevier.com*|*cell.com*|\
    *onlinelibrary.wiley.com*|*agupubs.onlinelibrary.wiley.com*|*wiley.com*|\
    *link.springer.com*|*springeropen.com*|*springer.com*|*nature.com*|\
    *science.org*|*sciencemag.org*|\
    *tandfonline.com*|*cambridge.org/core*|*cambridge.org/journals*|\
    *academic.oup.com*|*journals.aps.org*|*pubs.acs.org*|\
    *pubs.geoscienceworld.org*|*pubs.rsc.org*|*ieeexplore.ieee.org*|\
    *doi.org*|*dx.doi.org*|\
    *mcgill.ca/*|*.edu/~*|*.edu/faculty/*|*.edu/courses/*)
        reason=$(printf 'ethical-check (PreToolUse hook, publisher domain detected):\n\nThe URL %s matches a publisher, DOI resolver, or course-materials pattern. Before fetching, verify:\n\n1. Is access authorized? (Institutional subscription, author copy, or fully open-access CC-BY/PMC/public-domain.)\n2. Does the publisher permit automated text/data mining and AI use? (Check TDM clause; default "no" for Elsevier, Wiley, Springer, Nature, Science when unknown.)\n3. Is the content under embargo?\n\nIf any answer is "unsure," prefer the user-upload workflow from feedback_publisher_pdf_uploads.md: the user downloads through their institutional access, you work from the local PDF. For fully-OA content, proceed and capture license/source info for the literature inventory.\n\nAsk the user before fetching if you have not already confirmed authorization.' "$url")

        python3 -c 'import json, sys
ctx = sys.stdin.read()
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "additionalContext": ctx,
    }
}))
' <<< "$reason"
        ;;
    *)
        exit 0
        ;;
esac
