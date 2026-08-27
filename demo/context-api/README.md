# Context API demo

Everything here was **run against `adamgordonbell-org` on Aug 27 2026** and
returned the numbers quoted below. `./query.sh <selector.json>` runs any of them.

## Why this earns a spot

The workshop argues that Neo needed to reach past what Pulumi records. The
Context API is the other half of that sentence — the named, queryable form of
"what Pulumi knows" — and one query against Adam's real org states the problem
in a single number.

## The demo, in three commands

### 1. How much of this org does Pulumi actually manage?

```bash
./query.sh coverage-by-tool.json
```

Verified result, Aug 27:

| `managed` | resources |
|---|---|
| Other | **1305** |
| Pulumi | **144** |

**About 90% of what's in the account is not managed by Pulumi.** That is the
whole argument for the CLI integrations, quantified, on a real org, live.

`Other` here means found by a cloud scan and attributed to no IaC tool. The
schema's closed value set for `managed` is `ARM`, `CloudFormation`, `Other`,
`Pulumi`, `Terraform` — so an org with Terraform in it splits differently, which
is a good aside if someone asks.

### 2. What kind of thing is unmanaged?

```bash
./query.sh unmanaged-by-type.json
```

Real buckets: 62 CloudFront distributions, 26 cache policies, 19 origin access
identities, plus autoscaling groups, budgets, event rules. By account:
1229 in `aws-ca-central/global`, 76 in `aws-ca-central/ca-central-1`.

⚠️ `limit` bounds the number of *buckets*, not the resources counted in them.
At `limit: 15` you get 15 buckets alphabetically, not the top 15. Don't call
them "the biggest" on stage.

### 3. Unmanaged security groups — the tie into demo 2

```bash
./query.sh unmanaged-security-groups.json
```

Verified: **3 unmanaged security groups**, all in `aws-ca-central/ca-central-1`.

## ⚠️ Read this before wiring it to demo 2

**The graph can see unmanaged security groups.** Three of them, today, without
the AWS CLI. So "only the CLI can find this" — the claim demo 2 was built to
prove — is **too strong as written**, and someone who has read the launch post
will know it.

**The true distinction is index versus live**, and the agent primer says so
itself, under "Traps that produce a wrong answer rather than an error":

> Neither flag certifies index freshness. Queries answer from the search index,
> which trails the source of record by ingestion lag: a resource created,
> deleted, or rescanned moments ago can be missing or stale here with
> `resultMode: "exact"` and `visibility: "complete"`. When an absence answer
> carries real stakes — deleting "unused" infrastructure, a compliance
> attestation — confirm against stack state before acting.

`create-unmanaged.sh` makes a security group minutes before the demo. That is
exactly the resource the primer says the index may not have yet.

**Which makes a better beat than either half alone.** Ask the graph, get
nothing; ask `aws`, get the security group; and the vendor's own primer tells
you to confirm against the source of record. Three sources agreeing.

**But test it before promising it** — see the build-block item. If the scan has
already picked the group up, the beat inverts and you say "even the graph has it
now, and here's when it noticed," which is still true and still fine. Do not
script the punchline until the timing is known.

## Gotchas found while building this

- **Every aggregate metric needs an `alias`.** `{"op":"count"}` alone is a 400.
  The error names the fix — a fair demo of the "agents correct their own
  queries" claim, if you want to show a failure on purpose.
- **`metricOps` is `["count"]` only.** No sums or averages yet.
- **No cross-stack edges in this org.** All 69 stacks, zero
  `consumes_outputs_of` edges — so the blog's "what breaks if this changes"
  question has nothing to chew on here. Don't plan a blast-radius demo without
  building the dependency first.
- **Field projection came back null.** `return.fields` with `name`/`account`
  printed `None` per node; the values are reachable through `aggregate` instead.
  Worth another look before relying on projected fields on stage.
- **CLI is too old.** Local Pulumi is v3.237.0; `pulumi api` needs v3.243.0+.
  Everything here is `curl` for that reason. Upgrade and the demo gets to use
  `pulumi api GraphQuery -F orgName=<org> --input query.json`, which is a much
  better thing to show than a curl command.

## Access

Preview, **Enterprise and Business Critical only**. Part of the audience cannot
run this, so it must not carry a load-bearing beat. Uses the same permission as
Resource Search, and results are trimmed to the caller — the same acting-user
story the CLI-integration section tells.

The primer is the full grammar reference and is served by the API itself:

```bash
curl -H "Accept: text/markdown" -H "Authorization: token $PULUMI_ACCESS_TOKEN" \
  https://api.pulumi.com/api/insights/adamgordonbell-org/graph/schema
```
