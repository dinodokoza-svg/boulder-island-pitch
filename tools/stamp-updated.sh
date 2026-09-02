#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  Stamp the "last updated" date on the dashboard from the git commit date.
#
#  The pill at the top right of index.html reads this stamp, so the owners can
#  see the page is alive without anybody remembering to type a date.
#
#  Run it right before you push:
#
#      ./tools/stamp-updated.sh && git add index.html && git commit --amend --no-edit
#
#  or just run it and commit the one-line change on its own.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

cd "$(dirname "$0")/.."

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repository — nothing to stamp." >&2
  exit 1
fi

COMMIT_ISO="$(git log -1 --format=%cI)"

if [ -z "$COMMIT_ISO" ]; then
  echo "No commits yet — nothing to stamp." >&2
  exit 1
fi

python3 - "$COMMIT_ISO" <<'PY'
import re, sys, pathlib

iso = sys.argv[1]
path = pathlib.Path("index.html")
html = path.read_text(encoding="utf-8")

new, n = re.subn(
    r'(<meta name="bi:commit" content=")[^"]*(">)',
    lambda m: m.group(1) + iso + m.group(2),
    html,
    count=1,
)

if n == 0:
    sys.exit('Could not find the <meta name="bi:commit"> tag in index.html.')

if new != html:
    path.write_text(new, encoding="utf-8")
    print("Stamped index.html with " + iso)
else:
    print("Already stamped with " + iso + " — nothing to do.")
PY
