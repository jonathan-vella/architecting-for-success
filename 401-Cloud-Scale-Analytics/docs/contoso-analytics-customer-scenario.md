# Architecting For Success

## Cloud Scale Analytics Whiteboard Design Session

---

## Contoso Corporation

### Company background & information

- Contoso are a localized brand focusing on wholesale, distribution and retail and have their HQ in Athens with warehouses, distribution centres & shops located across the entire Greek territory.
- The CEO demands that no data is stored outside of the EU.
- COVID-19 accelerated their digital transformation and are now looking to aggressively migrate all workloads to Microsoft Azure.
- They are currently hosting all of their workloads on VMware vSphere and have 2 main sites - Athens (Prod DC) and Thessaloniki (DR DC).
- They have circa 75 virtual machines in production, and around 20 for Dev & Test scenarios, as well as Teradata Datawarehouse and Spark cluster deployments (Prod, Dev, Test)
- COVID-19 triggered a heavy investment in their online presence which is now a key business revenue stream accounting to 50% of their sales.
- They have a separate payment service which is subject to PCI-DSS.
- They have a MPLS connection between both DCs; some warehouses and disti. centers also act as internet breakout points for their shops.
- They are already using Microsoft 365 services.

---

### Technical Details

- They have an active Enterprise Agreement covering all Microsoft software.
- They have a mix of Microsoft 365 E3 and E5 licenses.
- They have 2 Azure subscriptions in use by developers as a sandbox.
- The on-premises AD DS domain is synchronized to AAD.
- They have a network team with strong skills in Cisco, Checkpoint, and F5.
- Some of the IT staff are trained and certified in Microsoft Azure (AZ-900, AZ-104, AZ-204 and some AZ-305, but no AZ-500 and no AZ-700).
- They have limited expertise and experience with ARM Templates, GitHub, and Azure DevOps.
- They have dedicated 10.0.0.0/16 as the IP address space for all networks in Azure.
- Their Teradata instance currently hosts 6TB of data and growing steadily with about 10GB of data per day.
- Their Datawarehouse is fed by downstream operational instances from various vendors (MS SQL Server, Oracle Databases, PostgreSQL Databases) via daily batches.
- Reporting is done leveraging Power BI Report Server. Models are hosted on a SQL Server Tabular Analysis Server that is built daily from Teradata using SSIS packages.
- They are using Spark to consume their Streaming data sources from a Kafka cluster (mostly clickstream data from their online retail sites). Data is then fed to the Datawarehouse for analytics.

---

### Requirements

- They have a license renewal for their Teradata Datawarehouse coming up in the next 6 months and would like to migrate this workload to the Cloud. Migration should happen within 3 months and would like to run parallel workloads to ensure correct reporting and minimize the migration downtime.
- They would like to move their reporting to Power BI Service
- They would like to optimize their reporting usage. Currently they have a team of 5 people developing reports, and all HQ users (50 in total) consume the reports generate on a daily basis.
- They would like to modernize their Spark infrastructure to enable additional workloads such as Machine Learning. They would also like to enable Streaming Analytics in their reports.
- They want to be able to easily create cost-related reports for each workload based on department, owner, and environment.
- They require the ability to deny certain Azure Resources and or Services and or locations. For example, a must-have is "No databases may be created in locations except in EU".
- They require separate Production, Staging & Development environments for security, agility and cost purposes. But they do not want to have development environments and associated VNETs to be able to communicate with production. Also, developers must granted "unrestricted" access to development environments at scale with minimal administrative overhead. No access should be granted to Test or Prod environments to developers.
- Production data must be backed up in a reliable way and protected against a regional failure. Dev/Test only need protection against localized failures.
- They require built-in platform regulatory compliance security checks and reporting for all production environments (PCI-DSS, ISO27001, CIS etc.)
  - ISO27001 for all environments except Sandbox subscriptions.
  - PCI-DSS for the payment system and associated data stores.
- All Subnets must be protected with NSGs and cannot be disabled.
- Azure Activity Logs for all Subscriptions & Diagnostic Settings for all Azure Resources should be enabled automatically and sent to a centralized LAW.
- For any VMs used, Azure Monitor VM Insights should be enabled and any required agents automatically installed.
- No Public IP Addresses are allowed in the environment except for core network functionality.
- They should receive alerts related to abnornmal consumption and budget overruns.
- They would like to start their Data Governance journey by implementing initially a Data Catalog. All data sources (including Dev and Test) need to be cataloged and correctly annotated. Every new data source must automatically be included in their Data Governance solution.
