#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = ["playwright"]
# ///
"""Brightspace content reader + pusher, via a logged-in browser (no API key needed).

CUNY SSO sessions do not survive into a separate headless process, so this works in a
SINGLE session: one browser opens, you log in once in that window if needed, and the same
live session reads or pushes. Reusable across courses on the same Brightspace instance;
per course you pass --html-dir and --pages-map.

  # read the course structure (opens a window; log in if prompted; prints modules/topics):
  ~/repos/claude-config/tools/brightspace_push.py discover --url=https://HOST/d2l/le/content/OU/Home

  # push rendered HTML into mapped topics (assisted paste; nothing saves without your click):
  ~/repos/claude-config/tools/brightspace_push.py push \
      --html-dir=/path/docs/brightspace/html --pages-map=/path/scripts/brightspace_pages.json --all

NOTE: glue flags to their values with '=' (e.g. --url=https://...), a stray space from a copy
can detach the value. macOS clipboard (pbcopy). Requires system Google Chrome.
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

from playwright.sync_api import sync_playwright

PROFILE_DIR = Path.home() / ".brightspace_push" / "chrome-profile"


def _clip(text: str) -> None:
    subprocess.run(["pbcopy"], input=text.encode("utf-8"), check=True)


def _ctx(p, headless: bool):
    PROFILE_DIR.mkdir(parents=True, exist_ok=True)
    return p.chromium.launch_persistent_context(
        user_data_dir=str(PROFILE_DIR),
        channel="chrome",
        headless=headless,
        no_viewport=not headless,
        args=["--no-first-run", "--no-default-browser-check"]
        + ([] if headless else ["--start-maximized"]),
    )


def _is_login(pg) -> bool:
    u = pg.url.lower()
    t = (pg.title() or "").lower()
    return "login" in u or "ssologin" in u or "login" in t


def _goto_authed(pg, url: str) -> bool:
    pg.goto(url, wait_until="load")
    pg.wait_for_timeout(2500)
    if _is_login(pg):
        print("\nNot signed in. In the Chrome window: log in to CUNY Brightspace (+ 2FA).")
        input("When you can SEE the course content in the window, press Enter here... ")
        pg.goto(url, wait_until="load")
        pg.wait_for_timeout(2500)
    return not _is_login(pg)


def cmd_discover(url: str, headless: bool) -> None:
    with sync_playwright() as p:
        ctx = _ctx(p, headless=headless)
        pg = ctx.pages[0] if ctx.pages else ctx.new_page()
        ok = _goto_authed(pg, url)
        print(f"\nlanded on:     {pg.url}")
        print(f"page title:    {pg.title()}")
        print(f"authenticated: {'YES' if ok else 'NO (still at login)'}")
        if ok:
            items: list[tuple[str, str]] = []
            seen: set[str] = set()
            for a in pg.locator("a[href*='/content/']").all():  # Playwright CSS pierces open shadow DOM
                try:
                    href = a.get_attribute("href") or ""
                    txt = (a.text_content() or "").strip()
                except Exception:
                    continue
                if txt and href and href not in seen:
                    seen.add(href)
                    items.append((txt, href))
            print(f"\ncontent links found ({len(items)}):")
            for txt, href in items:
                print(f"  - {txt[:72]:<72}  {href}")
        ctx.close()


def cmd_push(html_dir: str, pages_map: str, keys: list[str], auto: bool) -> None:
    pages = json.loads(Path(pages_map).read_text())
    hdir = Path(html_dir)
    targets = keys or [k for k in pages if not k.startswith("_")]
    with sync_playwright() as p:
        ctx = _ctx(p, headless=False)
        pg = ctx.pages[0] if ctx.pages else ctx.new_page()
        first = True
        for key in targets:
            url = pages.get(key)
            hf = hdir / f"{key}.html"
            if not url:
                print(f"[skip] {key}: no URL in pages-map")
                continue
            if not hf.exists():
                print(f"[skip] {key}: missing {hf}")
                continue
            if first:
                if not _goto_authed(pg, url):
                    print("Could not authenticate; aborting.")
                    break
                first = False
            else:
                pg.goto(url, wait_until="load")
            print(f"\n=== {key}  ->  {url} ===")
            _clip(hf.read_text())
            print("  HTML on clipboard. In the editor: Source Code (</>) view, Cmd+A, Cmd+V, Save.")
            input("  Press Enter for the next page (after you Save this one)... ")
        ctx.close()
        print("\nDone. Nothing was published without your Save click.")


def main() -> None:
    ap = argparse.ArgumentParser(description="Brightspace reader/pusher via a logged-in browser (no API key).")
    sub = ap.add_subparsers(dest="cmd", required=True)
    lp = sub.add_parser("login")
    lp.add_argument("--base-url", required=True)
    dp = sub.add_parser("discover")
    dp.add_argument("--url", required=True)
    dp.add_argument("--headless", action="store_true", help="(rarely works for CUNY SSO; default is headed)")
    up = sub.add_parser("push")
    up.add_argument("--html-dir", required=True)
    up.add_argument("--pages-map", required=True)
    up.add_argument("--page", action="append", default=[])
    up.add_argument("--all", action="store_true")
    up.add_argument("--auto", action="store_true", help="(reserved; assisted paste is the current mode)")
    a = ap.parse_args()
    if a.cmd == "login":
        with sync_playwright() as p:
            ctx = _ctx(p, headless=False)
            pg = ctx.pages[0] if ctx.pages else ctx.new_page()
            pg.goto(a.base_url)
            input("Log in (CUNY SSO + 2FA), then press Enter to save the session... ")
            ctx.close()
    elif a.cmd == "discover":
        cmd_discover(a.url, a.headless)
    else:
        if not a.page and not a.all:
            sys.exit("Give --page KEY (repeatable) or --all.")
        cmd_push(a.html_dir, a.pages_map, [] if a.all else a.page, a.auto)


if __name__ == "__main__":
    main()
