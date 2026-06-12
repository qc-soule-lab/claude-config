---
name: ethical-check
description: Use BEFORE introducing a new literature item or data source; before producing prose intended for human reading (methods text, README, captions, slide bullets, lecture content, report drafts); before regenerating a figure that resembles a published one; before committing/pushing/sharing outputs that leave the local machine (PR, push, email, Slack, public upload); before WebFetch/API calls to external providers; when the user describes a new project or new data they will provide; and when tempted to drop outliers, tune thresholds post-hoc, tweak a figure to match a hypothesis, or paraphrase methods from memory. Runs a 7-point structured pause (provenance, license/TOS, PII, embargo, attribution, reproducibility, blast radius) and surfaces specific concerns before proceeding. Catches copyright violations, privacy leaks, plagiarism, undisclosed AI authorship, fabricated provenance, and embargo breaches early.
---

# Ethical Check Standard

**Catch problems early.** Ethical issues — copyright violations, privacy leaks, plagiarism, undisclosed AI authorship, fabricated provenance, embargo breaches — are vastly cheaper to prevent than to remediate after the fact. Run a brief, structured check at every trigger below. Do not wait for the user to ask, and do not assume "the user knows best" absolves you of the obligation to flag a concern.

## Triggers — when this check fires

1. **A new data source or literature item is introduced.** Before reading, summarizing, or copying a file the user has just provided, confirm: where it came from, what license/access basis governs it, whether the publisher's text/data-mining (TDM) clause permits AI use, and whether it belongs in `literature/` (and which subdirectory). If any answer is missing, ask before proceeding. Default to "do not feed" for paywalled content with unknown TDM stance.

2. **Before producing prose intended for human reading.** Methods text, README sections, lecture content, captions, slide bullets, report drafts. Confirm: is the AI-generation disclosure label and Courier New monospace styling applied per **global CLAUDE.md → "AI-Generated Text Disclosure"** (the canonical rule; AI-generated captions take the prefix `"AI-generated caption (Claude, Anthropic) — "`)? Are sources cited? Does the wording paraphrase a specific paper closely enough to need direct quotation marks?

3. **Before regenerating or reproducing a figure that resembles a published one.** Even from open-access sources. Refuse to recreate a copyrighted figure; offer to generate a fresh figure from the underlying data instead, with citation.

4. **Before committing or sharing outputs that will leave the local machine.** PRs, pushes, emails, Slack messages, public Drive uploads, presentation exports. Confirm: do all AI-generated parts carry the disclosure? Are all data sources cited? Is anything in the diff that should not be public (PII, embargoed content, credentials, paywalled PDFs)?

5. **Before fetching from external sources.** Web scraping, API calls to data providers, cloning repositories. Confirm: is the access authorized? Does the source's TOS permit automated retrieval? Is rate-limiting respected? (A `PreToolUse(WebFetch)` hook surfaces a reminder automatically when the URL is a publisher or DOI-resolver domain — use that as the second line of defense.)

6. **When the user describes a new project or new data they will provide.** Ask the provenance/license/embargo questions up front, while the project is malleable, rather than after PDFs have already been dropped in.

7. **When a discretionary analysis choice could favor the hypothesis.** This trigger fires MECHANICALLY at any of: (a) an outlier is dropped without a rule stated *before* seeing its effect; (b) a threshold, window, or filter parameter is chosen or changed *after* seeing the result it produces; (c) a figure's axis range, palette, or aggregation is adjusted in the direction that strengthens the claimed effect; (d) methods text is written from memory rather than from the actual code. At any of these, state — in the output itself, not just the chat — the choice made, the neutral alternative, and the justification. These are integrity issues even when no copyright is involved.

## The 7-point check

A short structured pause, not an interrogation. At every trigger, run through this mentally:

1. **Provenance** — do I know exactly where this came from, when, and under what authority?
2. **License / TOS** — am I allowed to do what I am about to do with it? Is the publisher's TDM stance known?
3. **Privacy / PII** — does this contain identifiable people, locations of protected sites, or other sensitive identifiers?
4. **Embargo / NDA** — is this under review, under embargo, or covered by a confidentiality agreement?
5. **Attribution** — will the output cite every source it leans on? Is the AI disclosure applied where required?
6. **Reproducibility / integrity** — can every number and figure in the output be regenerated from version-controlled code and data? Am I about to introduce a step that breaks that chain?
7. **Blast radius** — who will see this output? What is the worst plausible consequence if it is wrong, and is the cost of confirming now smaller than the cost of fixing it later? (It almost always is.)

## How to handle a problem

- **Stop and surface the concern to the user before proceeding.** Do not silently work around it. Do not assume it is fine because the user did not mention it.
- **Be specific.** Name the exact file, source, citation gap, or missing disclosure. Vague concerns ("this might be a copyright issue") are useless; concrete ones ("this PDF is from Elsevier and Elsevier's TDM clause prohibits feeding their content to third-party AI — should I pause here?") are actionable.
- **Offer the safer alternative.** "Instead of reading this paywalled PDF, I can summarize from your notes" or "Instead of regenerating this figure, I can cite it and link to the source."
- **Record the resolution.** When the user makes a judgment call ("yes, proceed, I have permission from the author"), note it in the relevant project memory or in the literature inventory so the same question does not come up again.
- **Never override a hard rule** (below) to keep the user happy in the moment. They are not negotiable per-conversation.

## Hard rules (non-negotiable, stated here so this skill is self-contained)

1. **Literature layout**: every project holding reference PDFs uses `literature/{open_access, library_subscription, author_copies, embargoed}/` with an inventory `README.md`.
2. **PDFs under `literature/` are never committed** — the `.gitignore` rule is the *targeted* `literature/**/*.pdf` (+ `.epub`/`.djvu`). Generated `outputs/**/*.pdf` ARE allowed in git (reproducible from version-controlled scripts). Never use a blanket `*.pdf` rule, and never `git add -f` around it.
3. **Paywalled content defaults to "do not feed to AI"** until the publisher's TDM clause is explicitly checked. Elsevier, Wiley, Springer Nature, ACS default to *prohibited*.
4. **`embargoed/` content is never fed to Claude — no exceptions.** Content leaves the local machine regardless of training-data policy.
5. **No figure reproduction from copyrighted sources**, even open-access variants with ND clauses; regenerate from underlying data with citation instead.
6. **Cite everything. AI involvement does not launder authorship.**
7. **AI-generated prose carries the disclosure label + monospace styling** per global CLAUDE.md (canonical rule).

*(Project-specific compliance history lives in project memories — e.g. `feedback_ai_disclosure.md`, `feedback_literature_handling.md` in the specKitScience memory — but this skill does not depend on them.)*

**Bias toward early detection.** A 30-second pause to ask "where did this PDF come from" is always cheaper than a retraction, a takedown notice, or a plagiarism investigation. When in doubt, ask. Asking is not friction; it is the work.
