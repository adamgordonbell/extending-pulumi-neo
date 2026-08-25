#!/usr/bin/env bash
# Install what the deck and the demo programs need. Local only — nothing here
# logs in, deploys, or touches a cloud account.
set -euo pipefail
WS="${1:-$PWD}"

echo "==> slides"
( cd "$WS/slides" && npm install --no-audit --no-fund )

echo "==> demo program"
( cd "$WS/demo/pulumi-ts" && npm install --no-audit --no-fund )

echo "==> read-only role program"
( cd "$WS/demo/esc-readonly-role" && npm install --no-audit --no-fund )

cat <<'BANNER'

  Extending Pulumi Neo — workshop repo

    cd slides && npm run dev        the deck, on :3030
    demo/prewarm.sh                 pre-flight checks (read-only)
    demo/trigger-incident.sh        cause a real page
    demo/cleanup.sh                 reset between rehearsals

  Still manual, and deliberately so:
    pulumi login
    the PagerDuty / Linear / aws integrations, in the Neo org
    the read-only ESC environment  (see docs/credentials.md)

BANNER
