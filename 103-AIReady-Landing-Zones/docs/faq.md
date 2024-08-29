# Architecting for Success: AI-Ready Azure Landing Zones

## Contoso Azure Landing Zones - FAQ

## General Information

### What is the primary goal of Contoso's Azure Landing Zones project?
The primary goal is to securely and efficiently host Azure OpenAI related workloads, reduce on-premises infrastructure, and replace MPLS with a cloud-based solution. This includes enhancing SaaS application performance, decreasing WAN load, and ensuring compliance with regulatory standards.

## Technical Details

### What type of environment does Contoso operate?
Contoso operates a traditional hybrid data center environment, comprising physical and virtual servers, as well as Azure virtual machines. The infrastructure includes a mix of Windows and Linux servers, some of which run legacy applications.

### How many VMs and how much data does Contoso manage?
Contoso manages approximately 75 VMs for production, fewer than 20 for development and testing, and around 20TB of data from various sources.

### What critical applications are running on Contoso's VMs?
Some VMs run SAP HANA, utilizing a total of 4TB of RAM and 100TB of storage. The SAP landscape includes primary and secondary application servers, primary and secondary database servers, and a file server, all of which are critical and require high availability and disaster recovery.

### What connectivity exists between Contoso's on-premises and Azure environments?
A site-to-site (S2S) connection links the on-premises data center in Athens to Azure. Additionally, an MPLS connection exists between data centers, with some warehouses and distribution centers serving as internet breakout points.

### What are the current challenges with Contoso's CRM system?
The CRM system, used by both SAP and the payment service, runs on SQL Server 2019 Enterprise Edition. There have been ongoing performance issues between the payment service and the CRM system.

## Requirements

### What are the key requirements for Contoso's Azure environment?
- Securely host Azure OpenAI related workloads.
- Reduce on-premises infrastructure and replace MPLS with a cloud-based solution.
- Enforce policies to restrict resource creation to EU regions only.
- Detect and report on Azure resources lacking zone resilience.
- Isolate Production, Staging, and Development environments with restricted inter-environment communication.
- Apply network traffic filtering between Azure resources within an Azure virtual network.
- Ensure backup of all production VMs and selected VMs in development and test environments.
- Implement built-in platform regulatory compliance checks and reporting for all production environments, adhering to PCI-DSS and GDPR standards.
- Establish comprehensive observability across all resources and environments with minimal configuration effort.
- Limit Public IP Addresses to core network functionalities only.
- Configure alerts for abnormal consumption, cost overruns, and other cost-related anomalies.
- Set up alerts for the health, performance, and security status of all platform resources.
- Facilitate the generation of cost-related reports for each workload and application, categorized by department and environment.
- Implement a cost management solution to restrict the use of M-Series VMs, OpenAI, and Machine Learning services.
- Execute the migration of the SAP production landscape to Azure within a 6-week timeframe.
- Enhance the performance of the payment service by optimizing CRM system record retrieval.
- Implement a solution to monitor and manage the performance of the payment service and CRM system.

## Security and Compliance

### How does Contoso ensure compliance with regulatory standards?
Contoso implements built-in platform regulatory compliance checks and reporting for all production environments, adhering to PCI-DSS and GDPR standards.

### What measures are taken to secure network traffic within Azure?
Network traffic filtering is applied between Azure resources within an Azure virtual network. Additionally, policies are enforced to restrict resource creation to EU regions only.

## Cost Management

### How does Contoso manage and optimize cloud costs?
Contoso uses a cost management solution to restrict the use of M-Series VMs, OpenAI, and Machine Learning services. Alerts are configured for abnormal consumption, cost overruns, and other cost-related anomalies. Cost-related reports are generated for each workload and application, categorized by department and environment.

## Performance and Monitoring

### What steps are taken to monitor and manage the performance of critical applications?
A solution is implemented to monitor and manage the performance of the payment service and CRM system. Alerts are set up for the health, performance, and security status of all platform resources.

### How is the performance of the payment service optimized?
The performance of the payment service is enhanced by optimizing CRM system record retrieval.

## Migration

### What is the timeline for migrating the SAP production landscape to Azure?
The migration of the SAP production landscape to Azure is to be executed within a 6-week timeframe.