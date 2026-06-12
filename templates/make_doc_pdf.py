"""make_doc_pdf.py — Render a Markdown document to PDF for collaborator distribution.

Usage:
    uv run python scripts/make_doc_pdf.py outputs/docs/validation_questions_for_bob.md

Writes the PDF next to the source file with the same stem (.pdf).

Styling follows the project's AI-generated-text disclosure rules: Courier New
monospace body, italic disclosure label preserved at the top, tables with
visible borders, page breaks discouraged before headings.
"""

from __future__ import annotations

import sys
from pathlib import Path

import markdown as md
from weasyprint import HTML, CSS

CSS_PRINT = """
@page {
    size: Letter;
    margin: 0.75in 0.75in 1in 0.75in;
    @bottom-right { content: counter(page) " / " counter(pages); font-size: 9pt; color: #555; font-family: "Courier New", monospace; }
}

body {
    font-family: "Courier New", "Courier", monospace;
    font-size: 10pt;
    line-height: 1.45;
    color: #111;
}

h1 { font-size: 17pt; font-weight: 700; margin: 0 0 0.4em 0; padding-bottom: 0.2em; border-bottom: 1px solid #444; page-break-after: avoid; }
h2 { font-size: 13pt; font-weight: 700; margin: 1.2em 0 0.4em 0; padding-bottom: 0.15em; border-bottom: 1px solid #aaa; page-break-after: avoid; }
h3 { font-size: 11pt; font-weight: 700; margin: 1.0em 0 0.3em 0; page-break-after: avoid; }

p { margin: 0.5em 0; }

em { color: #444; }
strong { color: #000; }

ul, ol { margin: 0.4em 0 0.6em 1.4em; padding: 0; }
li { margin: 0.2em 0; }

code {
    font-family: "Courier New", "Courier", monospace;
    font-size: 9.5pt;
    background: #f4f4f4;
    padding: 0.05em 0.3em;
    border-radius: 2px;
}

pre {
    background: #f6f6f6;
    border: 1px solid #ddd;
    padding: 0.5em 0.7em;
    font-size: 9pt;
    overflow-wrap: break-word;
    page-break-inside: avoid;
}

table {
    border-collapse: collapse;
    margin: 0.6em 0 1em 0;
    font-size: 9.5pt;
    page-break-inside: avoid;
}
th, td {
    border: 1px solid #999;
    padding: 0.3em 0.55em;
    text-align: left;
    vertical-align: top;
}
th {
    background: #eaeaea;
    font-weight: 700;
}
td:has(+ td:last-child),
table td[align="right"], table th[align="right"] {
    /* numeric columns rendered right-aligned by GFM */
    text-align: right;
}

blockquote { margin: 0.6em 0; padding: 0.2em 0.8em; border-left: 3px solid #999; color: #444; }

hr { border: none; border-top: 1px solid #ccc; margin: 1.2em 0; }

a { color: #1a3d7c; text-decoration: none; word-break: break-all; }
"""


def render(src: Path) -> Path:
    text = src.read_text()
    html_body = md.markdown(
        text,
        extensions=["tables", "fenced_code", "toc", "sane_lists"],
        output_format="html5",
    )
    html_doc = (
        f"<!doctype html><html><head><meta charset='utf-8'>"
        f"<title>{src.stem}</title></head><body>{html_body}</body></html>"
    )
    out = src.with_suffix(".pdf")
    HTML(string=html_doc, base_url=str(src.parent)).write_pdf(
        str(out), stylesheets=[CSS(string=CSS_PRINT)]
    )
    return out


def main():
    if len(sys.argv) < 2:
        print(__doc__.strip())
        sys.exit(1)
    src = Path(sys.argv[1])
    if not src.exists():
        print(f"Not found: {src}", file=sys.stderr)
        sys.exit(2)
    out = render(src)
    print(f"Wrote {out} ({out.stat().st_size:,} bytes)")


if __name__ == "__main__":
    main()
