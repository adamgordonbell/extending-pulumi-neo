// Ad hoc, local Policy Pack used to evaluate the neo-workshop-incident/dev
// stack's program against the CIS AWS Foundations Benchmark controls that
// Pulumi's Compliance-Ready Policies library expresses as resource-level
// Crossguard checks. This mirrors the org's hosted "cis-aws" policy pack
// (https://github.com/pulumi/compliance-policies) without requiring policy
// group admin permissions to run a one-off audit.
import { PolicyPack } from "@pulumi/policy";
import { policyManager } from "@pulumi/compliance-policy-manager";
// Side-effect import: registers every AWS compliance-ready policy (tagged
// with its frameworks) into the shared policyManager singleton.
import "@pulumi/aws-compliance-policies";

new PolicyPack("cis-aws-benchmark", {
    policies: [
        ...policyManager.selectPolicies({ vendors: ["aws"], frameworks: ["cis"] }, "mandatory"),
    ],
});
