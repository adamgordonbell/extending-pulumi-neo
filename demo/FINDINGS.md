# What Neo is supposed to find

The demo program carries three deliberate configuration faults. Each is real —
these are bugs you would want caught — and each is **visible in a single look at
current state**.

That constraint is the whole design. A fresh PagerDuty trial and a fresh AWS
account have no history, so nothing here can depend on a trend. The launch blog's
marquee example (*"storage grew 5 GB/day for 30 days"*) and the *Ten More Things*
item 2 framing (*"the last 7 days of metrics"*) are both undemonstrable on a
two-week-old account. These are the same incidents, made visible without history.

| # | Fault | Where | Why it's real |
|---|-------|-------|---------------|
| 1 | `maxReceiveCount: 1` | `payment-queue` redrive policy | One transient failure and the message is dead-lettered. There is no retry at all. |
| 2 | Alarm with no actions | `payment-queue-age-alarm` | It evaluates, it goes red, nobody is told. The "but we had monitoring" postmortem. |
| 3 | `maxAllocatedStorage == allocatedStorage` | `payments-db` | Storage autoscaling is configured and inert — it can never grow the volume. |

## Fault 1 is doing two jobs

`maxReceiveCount: 1` is both the bug Neo diagnoses **and** what makes the beat
presentable. Engin's measured run, at `maxReceiveCount: 3`, took **3m45s** from
poison message to alarm and 3m49s to page. That is four minutes of dead air —
longer than the entire Linear beat.

At 1, with a 5-second visibility timeout, the message reaches the dead-letter
queue almost immediately and the remaining delay is just the alarm's 60-second
evaluation period.

⚠️ Fixing it is therefore a **PR, never applied live** — merging it during the
session would make the next rehearsal slow again.

## Suggested prompt

> There's an active PagerDuty incident. What's going on, and what would you change?

Do not name the faults. The demo is worth more if Neo finds them, and the whole
claim is that it can look for itself.

## If Neo finds something we didn't plan

Good — say so out loud and follow it. An agent finding a fourth real problem in
a program the presenter wrote is a better moment than the script.

## What it must not do

Neo needs **no write access** to any of this. The remediation is a pull request
against the program, and the read-only ESC environment is what proves it — see
`../docs/credentials.md`.
