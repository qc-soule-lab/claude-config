#!/usr/bin/env python3
"""Provision a per-student Azure container + scoped SAS for the qc-soule-lab data lake.

Creates a PRIVATE container `<project>-<student>` under the storage account and mints a
90-day `racwdl` SAS scoped to that container only. Per-student isolation: a leaked token
exposes one student's container, and you revoke by regenerating just that SAS.

Requires the STORAGE ACCOUNT KEY (a powerful credential — full account access). Fetch it
ONCE from the Azure portal: Storage account -> Security + networking -> Access keys -> key1.
Provide it via $AZURE_STORAGE_KEY or ~/.azure/<account>.key (chmod 600). Never commit it.

Usage:
  provision-student-azure.py <student> [--project scaleworm] [--account soulesciencedata] [--days 90]

The SAS is written to ~/.azure/handoff/<container>.env (chmod 600) — NOT printed to screen —
for you to hand to the student over a secure channel. They save it as ~/.azure/<container>.env.
"""

import argparse
import os
import re
import sys
from datetime import UTC, datetime, timedelta
from pathlib import Path


def main():
    ap = argparse.ArgumentParser(description="Provision a per-student Azure container + SAS.")
    ap.add_argument("student", help="student short name (becomes part of the container name)")
    ap.add_argument("--project", default="scaleworm", help="container prefix (default: scaleworm)")
    ap.add_argument("--account", default="soulesciencedata", help="storage account name")
    ap.add_argument("--days", type=int, default=90, help="SAS lifetime in days (default 90)")
    args = ap.parse_args()

    student = re.sub(r"[^a-z0-9-]", "-", args.student.lower()).strip("-")
    container = f"{args.project}-{student}"
    if not re.fullmatch(r"[a-z0-9](?:[a-z0-9-]{1,61}[a-z0-9])", container):
        sys.exit(
            f"error: '{container}' is not a valid Azure container name (3-63 chars, lowercase)."
        )

    key = os.environ.get("AZURE_STORAGE_KEY")
    if not key:
        keyfile = Path.home() / ".azure" / f"{args.account}.key"
        if keyfile.is_file():
            key = keyfile.read_text().strip()
    if not key:
        sys.exit(
            f"error: no storage key. Set $AZURE_STORAGE_KEY or put it in ~/.azure/{args.account}.key "
            "(chmod 600). Get it from the portal: Storage account -> Access keys -> key1."
        )

    try:
        from azure.storage.blob import (
            BlobServiceClient,
            ContainerSasPermissions,
            generate_container_sas,
        )
    except ImportError:
        sys.exit(
            "error: azure-storage-blob not installed. Run: python3 -m pip install --user azure-storage-blob"
        )

    svc = BlobServiceClient(f"https://{args.account}.blob.core.windows.net", credential=key)
    cc = svc.get_container_client(container)
    if not cc.exists():
        cc.create_container()
        print(f"created private container: {container}", file=sys.stderr)
    else:
        print(f"container already exists: {container}", file=sys.stderr)

    expiry = datetime.now(UTC) + timedelta(days=args.days)
    sas = generate_container_sas(
        account_name=args.account,
        container_name=container,
        account_key=key,
        permission=ContainerSasPermissions(
            read=True, add=True, create=True, write=True, delete=True, list=True
        ),
        expiry=expiry,
        # HTTPS-only is the SDK default for generate_container_sas via the protocol param:
    )
    url = f"https://{args.account}.blob.core.windows.net/{container}?{sas}"

    handoff = Path.home() / ".azure" / "handoff"
    handoff.mkdir(parents=True, exist_ok=True)
    os.chmod(handoff, 0o700)
    out = handoff / f"{container}.env"
    out.write_text(f"export AZURE_BLOB_SAS_URL='{url}'\n")
    os.chmod(out, 0o600)

    print(f"SAS written (racwdl, expires {expiry.date()}): {out}", file=sys.stderr)
    print(
        f"-> deliver this file SECURELY to '{args.student}'; they save it as ~/.azure/{container}.env (chmod 600).",
        file=sys.stderr,
    )
    print(
        f"-> set a reminder to regenerate before {expiry.date()}. The SAS is a bearer credential — do not print/commit it.",
        file=sys.stderr,
    )
    print(container)  # stdout: container name (for scripting)


if __name__ == "__main__":
    main()
