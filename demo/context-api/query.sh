#!/usr/bin/env bash
# Run a Context API selector against the org. Usage: ./query.sh <selector.json>
set -euo pipefail
ORG="${PULUMI_ORG:-adamgordonbell-org}"
TOKEN="${PULUMI_ACCESS_TOKEN:-$(python3 -c "import json,os;d=json.load(open(os.path.expanduser('~/.pulumi/credentials.json')));print(d['accessTokens'][d['current']])")}"
curl -s -X POST "https://api.pulumi.com/api/insights/${ORG}/graph/query" \
    -H "Authorization: token ${TOKEN}" \
    -H "Content-Type: application/json" \
    --data @"$1" | python3 -m json.tool
