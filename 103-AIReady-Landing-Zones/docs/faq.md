# Contoso ALZ Customer Scenario FAQ

## Current Setup

**Q: How many VMs does Contoso ALZ have for Prod, Dev & Test, and how much data do they have?**  
A: They have approximately 75 VMs for Prod, less than 20 for Dev & Test, and ~20Tb of data across multiple sources.

**Q: What is the setup of the SAP landscape?**  
A: Some of these VMs are running SAP HANA, with a total of 4TB of RAM and 100TB of storage. The SAP landscape includes a primary and secondary application server, a primary and secondary database server, and a file server.

**Q: What is the connection between the on-premises DC in Athens and Azure?**  
A: A S2S connection exists between the on-premises DC in Athens and Azure.

**Q: What is the setup of the payment service and CRM system?**  
A: A payment service, subject to PCI-DSS, is hosted on Azure VMs. A SQL Server 2019 Enterprise Edition is used for the CRM system; this CRM system is used by both SAP and the payment service.

**Q: What is the connection between DCs?**  
A: A MPLS connection exists between DCs, with some warehouses and distribution centers acting as internet breakout points.

**Q: What Microsoft services are used?**  
A: Microsoft 365 services are used, but there are gaps in the identity security posture.

**Q: How many Azure subscriptions are in use?**  
A: Two Azure subscriptions are in use: one for production workloads and another for developer sandbox connected to the production network.

**Q: What is the expertise of the network team?**  
A: Network team has expertise in Cisco, Checkpoint, and F5.

**Q: What is the expertise and experience with IaC and DevOps?**  
A: There is limited expertise and experience with IaC and DevOps.

## Requirements

**Q: What is the timeline for migrating the SAP production landscape to Azure?**  
A: The SAP production landscape needs to be migrated to Azure within 6 weeks.

**Q: What is the requirement for the performance of the payment service?**  
A: The performance of the payment service when reading records from the CRM system needs to be optimized.

**Q: What is the requirement for creating resources?**  
A: The ability to create resources outside of the EU needs to be blocked.

**Q: What is the requirement for Azure resources?**  
A: Existing Azure resources which are not zone resilient need to be identified.

**Q: What is the requirement for cost-related reports?**  
A: Cost-related reports for each workload and application based on department and environment need to be easily generated.

**Q: What is the requirement for a cost avoidance solution?**  
A: A cost avoidance solution which will restrict the use of M-Series VMs and Machine Learning services needs to be implemented.

**Q: What is the requirement for the on-premises footprint and MPLS?**  
A: The on-premises footprint needs to be minimized and MPLS replaced with a cloud-based approach. Local internet breakout from all sites to improve SaaS application performance and reduce WAN load needs to be enabled.

**Q: What is the requirement for the environments?**  
A: Production, Staging, and Development environments need to be separated with restricted communication between them.

**Q: What is the requirement for network traffic?**  
A: The filtering of network traffic between Azure resources in an Azure virtual network needs to be enforced.

**Q: What is the requirement for VM backups?**  
A: All production VMs and selected VMs in dev & test environments need to be backed up.

**Q: What is the requirement for regulatory compliance security checks and reporting?**  
A: Built-in platform regulatory compliance security checks and reporting for all production environment (PCI-DSS and GDPR) need to be implemented.

**Q: What is the requirement for observability of resources?**  
A: Observability of all resources across all environments with minimal effort needs to be implemented.

**Q: What is the requirement for Public IP Addresses?**  
A: Public IP Addresses need to be restricted to core network functionality only.

**Q: What is the requirement for cost-related alerts?**  
A: Cost-related alerts for abnormal consumption, cost overruns, etc. need to be received.

**Q: What is the requirement for alerts related to the health, performance, and security of all platform resources?**  
A: Alerts related to the health, performance, and security of all platform resources need to be received.