#!/usr/bin/env bash
# Cause a real PagerDuty page, on demand.
#
# Sends a payment message with no "amount". Nothing consumes it successfully, so
# after maxReceiveCount failed receives SQS moves it to the dead-letter queue,
# the alarm goes red, SNS notifies PagerDuty, and an incident opens.
#
# Timing: with maxReceiveCount 1 and a 5s visibility timeout this is fast, but
# the CloudWatch alarm still evaluates on a 60s period. Budget ~1-2 minutes from
# running this to the page. Engin's original (maxReceiveCount 3) took 3m45s —
# too long to run inside a beat.
#
# ⇒ RUN THIS DURING THE PREVIOUS BEAT, not at the top of the incident beat.
set -euo pipefail
cd "$(dirname "$0")/pulumi-ts"

QUEUE_URL=$(pulumi stack output paymentQueueUrl)

aws sqs send-message \
    --queue-url "$QUEUE_URL" \
    --message-body '{"orderId":"4712","currency":"EUR"}' \
    --no-cli-pager >/dev/null

echo "Poison payment sent to the payment queue."
echo "Watch the alarm flip:"
echo "  aws cloudwatch describe-alarms --alarm-names \"$(pulumi stack output alarmName)\" \\"
echo "    --query 'MetricAlarms[0].StateValue' --output text"
echo
echo "Incident will open on: $(pulumi stack output pagerdutyServiceUrl)"
