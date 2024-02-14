# Architecting for Success - Azure Landing Zones

## Contoso Corporation

### Company background & information

- Contoso is a family-owned business that has been operating since 1978. It has a loyal customer base and a strong reputation in the Greek market. They focus on wholesale, distribution and retail having their HQ in Athens with warehouses, distribution centres & shops located across the entire territory.
- The CEO is concerned about the data privacy and security regulations in the EU, such as GDPR and ePrivacy Directive. He wants to ensure that Contoso complies with these laws and does not risk any fines or penalties.
- Contoso’s cloud-first journey started in 2020, when the COVID-19 pandemic disrupted their traditional business model and forced them to adapt to the changing customer behavior and expectations. They decided to migrate a payment processing application to Azure.
- When they embarked on their cloud-first journey, Azure Landing Zones were not a priority, but now they are since they are looking to scale their cloud operations and ensure that they are reliable, secure, compliant, and cost-effective.
- The CEO understands that over time they have accumulated a significant amount of date and is very curious about how Contoso could possibly monetize their data.
- Sales and marketing teams are currently exploring how they can use AI to improve customer experience and increase sales.
- The inventory management team is also looking at how they can use IoT and AI to improve their stock management.

### Business goals

- They want to accelerate their cloud migration and reduce business & migration risks.
 They want to ensure that their cloud operations are reliable, secure, and compliant. They also want to ensure that they can scale their cloud operations as they grow.
- Optimize cloud costs and governance by establishing budgets, policies, and controls.
- Be in a position to innovate and grow their business by leveraging cloud solutions whilst minimizing rework and technical debt.
- They want to ensure that they are compliant with the EU data privacy and security regulations, such as GDPR and ePrivacy Directive.
- They want to ensure that their online presence is resilient and performs well to meet customer expectations.
- They want to ensure that in the future their inventory management is efficient and effective by leveraging IoT and AI.
- They want to ensure that their sales and marketing teams can use AI to improve customer experience and increase sales.

### Technical details

- They currently host all their workloads on VMware vSphere and have 2 main sites - Athens (Prod DC) and Thessaloniki (DR DC).
- They have circa 75 VMs for Prod, less than 20 for Dev & Test, and ~20Tb of data across multiple sources.
- They have a separate payment service which is subject to PCI-DSS. This payment service is hosted on a separate set of Azure VMs.
- They have a MPLS connection between both DCs; some warehouses and disti. centers also act as internet breakout points for their shops.
- They are using Microsoft 365 services, but have gaps in their identity security posture.
- They have 2 Azure subscriptions in use; one is for all of their production workloads in Azure and the other is used by developers as a sandbox which is connected to the production network.
- The on-premises AD DS domain is synchronized to AAD.
- They have a network team with strong skills in Cisco, Checkpoint, and F5.
- Some of the IT staff are trained and certified in Microsoft Azure (AZ-900, AZ-104, AZ-204 and some AZ-305, but minimal expertise related to security, data, and networking).
- They have limited expertise and experience with IaC and DevOps.
- They have dedicated 10.0.0.0/16 as the IP address space for all networks in Azure.

### Requirements

- They want to quickly and easily identify which existing resources in Azure are not zone resilient.
- They want to migrate the SAP production landscape to Azure. Migration must be completed in less than 6 weeks due to capacity and reliability issues with their datacenters. Customer recently experienced capacity-related outages which resulted in unexpected downtime and data loss.
- They want to be able to easily create cost-related reports for each workload based on department, owner, and environment.
- They want to minimize their existing on-premises footprint and want to replace the existing MPLS solution with a 'cloud-based' approach.
- They want to start allowing local internet breakout from all sites to improve SaaS application performance and reduce the load on their WAN.
- They require the ability to deny certain Azure Resources and or Services. For example, a must-have is "No M-Series or L-Series VMs can be deployed except for the SAP environments".
- They require separate Production, Staging & Development environments for security, agility and cost purposes. But they do not want to have development environments and associated VNETs to be able to communicate with production. Also, developers must granted "unrestricted" access to development environments at scale with minimal administrative overhead.
- All production VMs must be backed up, and some selected VMs in dev & test environments also need to be protected.
- They require built-in platform regulatory compliance security checks and reporting for all production environments (PCI-DSS, ISO27001, CIS etc.)
  - ISO27001 for all environments except Sandbox subscriptions.
  - PCI-DSS for the SAP and payment system.
- All Subnets must be protected with NSGs and cannot be disabled.
- Azure Activity Logs for all Subscriptions & Diagnostic settings for all Azure Resources should be enabled automatically and sent to a centralized workspace.
- Auditing should be enforced on all Azure SQL Databases.
- Observability of all resources is a key requirement which must be met with minimal effort.
- No Public IP Addresses are allowed in the environment except for core network functionality, sandbox environments, and online applications.
- They should receive alerts related to abnormal consumption, cost overruns, etc.