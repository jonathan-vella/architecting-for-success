# Architecting for Success - Azure Landing Zones

## Contoso Corporation

### Company background & information

- Contoso is a family-owned business that has been operating since 1978. They focus on wholesale, distribution, and retail, with their headquarters in Athens and locations across Greece.
- The CEO is concerned about data privacy and security regulations in the EU, such as GDPR and ePrivacy Directive. Compliance is a top priority.
- Contoso started their cloud journey in 2020, migrating a payment processing application to Azure due to the COVID-19 pandemic.
- Azure Landing Zones are now a priority as Contoso aims to scale their cloud operations and ensure reliability, security, compliance, and cost-effectiveness.
- The CEO is interested in monetizing their data and exploring AI for customer experience improvement and increased sales.
- The inventory management team is exploring IoT and AI for stock management improvement.

### Business goals

- Accelerate cloud migration, reduce risks, and ensure reliable, secure, and compliant cloud operations.
- Optimize cloud costs and governance through budgets, policies, and controls.
- Leverage cloud solutions for innovation and business growth while minimizing rework and technical debt.
- Ensure compliance with EU data privacy and security regulations.
- Ensure resilient and high-performing online presence.
- Improve inventory management efficiency with IoT and AI.
- Use AI to enhance customer experience and increase sales.

### Technical details

- Workloads are currently hosted on VMware vSphere with two main sites in Athens (Prod DC) and Thessaloniki (DR DC).
- They have approximately 75 VMs for Prod, less than 20 for Dev & Test, and ~20Tb of data across multiple sources.
- A separate payment service, subject to PCI-DSS, is hosted on Azure VMs.
- MPLS connection exists between DCs, with some warehouses and distribution centers acting as internet breakout points.
- Microsoft 365 services are used, but there are gaps in identity security posture.
- Two Azure subscriptions are in use: one for production workloads and another for developer sandbox connected to the production network.
- On-premises AD DS domain is synchronized to AAD.
- Network team has expertise in Cisco, Checkpoint, and F5.
- Limited expertise and experience with IaC and DevOps.
- Dedicated 10.0.0.0/16 IP address space for Azure networks.

### Requirements

- Identify existing Azure resources that are not zone resilient.
- Migrate SAP production landscape to Azure within 6 weeks.
- Easily generate cost-related reports for each workload based on department, owner, and environment.
- Minimize on-premises footprint and replace MPLS with a cloud-based approach.
- Enable local internet breakout from all sites to improve SaaS application performance and reduce WAN load.
- Ability to deny certain Azure Resources and Services, such as restricting M-Series or L-Series VMs except for SAP environments.
- Separate Production, Staging, and Development environments with restricted communication between them.
- Backup all production VMs and selected VMs in dev & test environments.
- Built-in platform regulatory compliance security checks and reporting for all production environments.
- NSGs to protect all subnets, which cannot be disabled.
- Enable Azure Activity Logs and Diagnostic settings for all Azure Resources in a centralized workspace.
- Enforce auditing on all Azure SQL Databases.
- Ensure observability of all resources with minimal effort.
- Restrict Public IP Addresses to core network functionality, sandbox environments, and online applications.
- Receive alerts for abnormal consumption, cost overruns, etc.
