# Architecting for Success - Azure Landing Zones

---

## Challenge 05 - Automated Governance Reporting (90mins)

In this challenge you will be implementing the [Azure Governance Visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) which is a PowerShell based script that iterates your Azure Tenant´s Management Group hierarchy down to Subscription level. It captures most relevant Azure governance capabilities such as Azure Policy, RBAC and Blueprints and a lot more. From the collected data Azure Governance Visualizer provides visibility on your HierarchyMap, creates a TenantSummary, creates DefinitionInsights and builds granular ScopeInsights on Management Groups and Subscriptions. You will be using the accelerator to speed up the adoption of the script into your environment.

>Since Azure Resource Manager sometimes caches configurations and data to improve performance, it can sometimes take up to 30 minutes for changes to take effect when you assign roles or remove role assignments.

## Challenge 05 - Success criteria

1. Take your time and read the [setup guide](https://github.com/Azure/Azure-Governance-Visualizer-Accelerator). And read the note above! If you need to create new identities and assign roles, do it now.
2. Setup AzGovViz with GitHub Actions using OIDC.
3. Publishing the AzGovViz HTML to an Azure Web App.
4. Explore how your Azure environment is represented in AzGovViz
