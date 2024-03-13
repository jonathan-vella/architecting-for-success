# Architecting for Success - Azure Landing Zones

---

## Challenge 02 - Deploying Azure Landing Zones (1.5hrs)

In this challenge you will be deploying the Azure Landing Zones reference implementation located in this [repository](https://github.com/Azure/Enterprise-Scale) using the Azure Portal experience, which is the quickest way to deploy the ALZ conceptual architecture.
Alternatively you can deploy the [ALZ Bicep Accelerator](https://github.com/Azure/ALZ-Bicep/wiki/Accelerator) using either GitHub Actins option Azure DevOps Pipelines.
There's also a Terraform option which you can find [here](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/deploy-landing-zones-with-terraform) but this is out-of-scope for this challenge.

---

## Challenge 02 - Success criteria

1. Plan and document your IP addressing. Customer's preference is to start with a hub & spoke network topology with Azure Firewall, Azure VPN Gateway, and Azure Bastion,. Your deliverables should include multiple VNETs (hub, shared services) and should account for inter-region traffic. In your plan, clearly document subnet names, whether the use of NSGs and / or UDRs is allowed by Azure, and the minimum recommended subnet size. You must include references to online documentation to support your design decisions. You can either use the provided [template](./../docs/Azure%20Network%20Documentation%20Template.xlsx) or build your own.
2. Document your design decisions related to Entra ID tenant, RBAC permissions, number of subscriptions, naming & tagging conventions, etc.
3. Document your deployment workflow.
4. Successfully deploy the reference implementation using either the Azure Portal experience or the ALZ Bicep Accelerator. You must provide screenshots of the deployment process and the final state of the deployed resources.