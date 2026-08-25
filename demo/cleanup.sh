#!/usr/bin/env bash
# Reset between rehearsals: purge the dead-letter queue so the alarm returns to
# OK and PagerDuty resolves the incident on its own.
#
# SQS allows one purge per queue per 60 seconds. If you are re-running quickly,
# wait it out rather than retrying in a loop.
set -euo pipefail
cd "$(dirname "$0")/pulumi-ts"

DLQ_URL=$(pulumi stack output dlqUrl)
QUEUE_URL=$(pulumi stack output paymentQueueUrl)

aws sqs purge-queue --queue-url "$DLQ_URL" --no-cli-pager
aws sqs purge-queue --queue-url "$QUEUE_URL" --no-cli-pager || true

echo "Queues purged. The alarm returns to OK on its next evaluation (up to 60s)"
echo "and PagerDuty resolves the incident automatically."
echo
echo "If an incident is still open afterwards, resolve it in the PagerDuty UI —"
echo "a stale open incident makes the next rehearsal ambiguous."
