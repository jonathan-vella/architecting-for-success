# Architecting for Success: AI-Ready Azure Landing Zones

## Contoso Corporation

### Executive summary

Contoso, a family-owned business established in 1978, specializes in wholesale, distribution, and retail. Headquartered in Athens, with locations across Greece, they embarked on their cloud journey in 2020 by migrating a payment processing application to Azure due to the COVID-19 pandemic. The CEO envisions modernizing their IT infrastructure and leveraging cloud technologies to drive business growth and innovation.

While the IT team is enthusiastic about this cloud journey, they lack expertise in cloud technologies and best practices. They seek guidance to accelerate cloud adoption, ensuring a reliable, secure, and compliant environment. Additionally, they aim to optimize costs and leverage AI to enhance customer experience and boost sales. The CEO prioritizes compliance with EU data privacy and security regulations, such as GDPR and the ePrivacy Directive.

The IT team focuses on migrating workloads to Azure, optimizing costs, and ensuring high availability and disaster recovery. They seek guidance on designing and implementing an **Azure OpenAI-ready cloud environment** that meets their business and technical requirements. They are interested in best practices, reference architectures, and automation to accelerate cloud adoption, as well as guidance on monitoring, managing, and securing their cloud environment.

### Business goals

Contoso aims to achieve the following business goals:

- Speed up the transition to the cloud while minimizing risks.
- Utilize AI to improve customer experience and boost sales.
- Manage and reduce cloud-related costs effectively.
- Use cloud-based solutions to drive innovation and business growth.
- Comply with EU data privacy and security regulations.
- Maintain a reliable and high-performing online presence.
- Enhance the payment service’s performance when accessing CRM records.
- Reduce reliance on on-premises infrastructure and switch to a cloud-based network.
- Improve SaaS application performance and reduce network load by enabling local internet access from all sites.
- Keep Production, Staging, and Development environments separate with limited communication between them.
- Control network traffic between Azure resources within a virtual network.

### Technical details

- Contoso operates a traditional hybrid data center (DC) environment, comprising physical, virtual servers and Azure virtual machines.
- Their infrastructure includes a mix of Windows and Linux servers, some of which run legacy applications.
- Workloads are hosted on VMware vSphere, with primary sites in Athens (Production DC) and Thessaloniki (Disaster Recovery DC).
- The environment consists of approximately 75 VMs for production, fewer than 20 for development and testing, and around 20TB of data from various sources.
- Some VMs run SAP HANA, utilizing a total of 4TB of RAM and 100TB of storage. The SAP landscape includes primary and secondary application servers, primary and secondary database servers, and a file server, all of which are critical and require high availability and disaster recovery.
- A site-to-site (S2S) connection links the on-premises DC in Athens to Azure.
- A payment service, compliant with PCI-DSS, is hosted on Azure VMs.
- The CRM system, used by both SAP and the payment service, runs on SQL Server 2019 Enterprise Edition. There have been ongoing performance issues between the payment service and the CRM system.
- An MPLS connection exists between DCs, with some warehouses and distribution centers serving as internet breakout points.
- Microsoft 365 services are in use, though there are gaps in the identity security posture.
- Two Azure subscriptions are utilized: one for production workloads and another for a developer sandbox connected to the production network.
- The on-premises Active Directory Domain Services (AD DS) domain is synchronized with Entra ID.
- The network team has expertise in Cisco, Checkpoint, and F5 technologies.
- There is limited expertise and experience with Infrastructure as Code (IaC) and DevOps practices.
- A dedicated 10.0.0.0/16 IP address space is allocated for Azure networks.

### Requirements

- An Azure environment which is ready to securely and efficiently host Azure OpenAI related workloads.
- Reduce on-premises infrastructure and replace MPLS with a cloud-based solution, enabling local internet breakout from all sites to enhance SaaS application performance and decrease WAN load.
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
- Implement a cost management solution to restrict the use of M-Series VMs, OpenAI and Machine Learning services.
- Execute the migration of the SAP production landscape to Azure within a 6-week timeframe.
- Enhance the performance of the payment service by optimizing CRM system record retrieval.
- Implement a solution to monitor and manage the performance of the payment service and CRM system.