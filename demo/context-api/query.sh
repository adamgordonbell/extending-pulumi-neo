#!/usr/bin/env bash
# Run a Context API selector against the org. Usage: ./query.sh <selector.json>
#
# Prefers the native CLI (`pulumi api`, needs v3.243.0+) and falls back to curl.
set -euo pipefail
ORG="${PULUMI_ORG:-adamgordonbell-org}"

if pulumi api GraphQuery --help >/dev/null 2>&1; then
    pulumi api GraphQuery -F "orgName=${ORG}" --input "$1"
else
    echo "note: pulumi api unavailable (need CLI v3.243.0+) - falling back to curl" >&2
    TOKEN="${PULUMI_ACCESS_TOKEN:-$(python3 -c "import json,os;d=json.load(open(os.path.expanduser('~/.pulumi/credentials.json')));print(d['accessTokens'][d['current']])")}"
    curl -s -X POST "https://api.pulumi.com/api/insights/${ORG}/graph/query" \
        -H "Authorization: token ${TOKEN}" \
        -H "Content-Type: application/json" \
        --data @"$1" | python3 -m json.tool
fi
