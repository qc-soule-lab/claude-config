#!/usr/bin/env python3
"""Rotate the lab data-lake container SAS tokens.

Regenerates a fresh SAS for each lab container on the soulesciencedata account
and rewrites ~/.azure/<container>.env (chmod 600). Prints only container names,
permissions, and expiry dates; the SAS itself never reaches stdout.

Requires the storage ACCOUNT KEY at ~/.azure/soulesciencedata.key (chmod 600)
or in $AZURE_STORAGE_KEY. Fetch it once from the portal: Storage account ->
Security + networking -> Access keys -> key1. Never commit it.

Usage:
  rotate_lab_sas.py                # rotate the default containers, 90 days
  rotate_lab_sas.py --days 30
  rotate_lab_sas.py --containers magma2vents bravoseis
"""

import argparse
import os
import stat
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

ACCOUNT = "soulesciencedata"
DEFAULT_CONTAINERS = ["magma2vents", "bravoseis", "my-data-backup"]


def main() -> int:
    ap = argparse.ArgumentParser(description="Rotate lab container SAS tokens.")
    ap.add_argument("--containers", nargs="+", default=DEFAULT_CONTAINERS)
    ap.add_argument("--days", type=int, default=90, help="SAS lifetime (default 90)")
    ap.add_argument("--account", default=ACCOUNT)
    args = ap.parse_args()

    key = os.environ.get("AZURE_STORAGE_KEY")
    if not key:
        keyfile = Path.home() / ".azure" / f"{args.account}.key"
        if keyfile.is_file():
            key = keyfile.read_text().strip()
    if not key:
        print(
            f"error: no storage key. Put key1 in ~/.azure/{args.account}.key "
            "(chmod 600) or set $AZURE_STORAGE_KEY.",
            file=sys.stderr,
        )
        return 1

    from azure.storage.blob import ContainerSasPermissions, generate_container_sas

    start = datetime.now(timezone.utc) - timedelta(minutes=15)
    expiry = datetime.now(timezone.utc) + timedelta(days=args.days)
    perms = ContainerSasPermissions(
        read=True, add=True, create=True, write=True, delete=True, list=True
    )

    env_dir = Path.home() / ".azure"
    for name in args.containers:
        sas = generate_container_sas(
            account_name=args.account,
            container_name=name,
            account_key=key,
            permission=perms,
            start=start,
            expiry=expiry,
        )
        url = f"https://{args.account}.blob.core.windows.net/{name}?{sas}"
        env_path = env_dir / f"{name}.env"
        env_path.write_text(f"export AZURE_BLOB_SAS_URL='{url}'\n")
        env_path.chmod(stat.S_IRUSR | stat.S_IWUSR)
        print(f"{name}: racwdl, expires {expiry:%Y-%m-%d %H:%M}Z -> {env_path}")
    print("done. Other machines (Hub, DellPC, MacBook) still need their env files updated.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
