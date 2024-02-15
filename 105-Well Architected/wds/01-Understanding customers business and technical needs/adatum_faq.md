# Adatum Deliveries FAQ

## General

**Q: What is the business model of Adatum Deliveries?**  
A: Adatum Deliveries is a logistics company that provides next-day delivery services across the European Union. They manage an international fleet of planes, trains, and delivery vehicles.

**Q: Where is Adatum Deliveries headquartered?**  
A: Adatum Deliveries is headquartered in Paris, France.

**Q: What is the technology landscape of Adatum Deliveries?**  
A: Adatum Deliveries has an on-premises datacenter at their headquarters and a custom Azure-hosted delivery platform called SmartDelivery. SmartDelivery provides services to schedule, track, and fulfill deliveries and serves as a backend for client apps.

**Q: Does Adatum Deliveries have any disaster recovery plans?**  
A: No, Adatum Deliveries currently does not have any existing disaster recovery plans.

## Operational Model

**Q: What is the operational model of Adatum Deliveries?**  
A: Adatum Deliveries follows a centralized operational model, with the exception of SmartDelivery which is managed by an autonomous development team. They also have a newly formed Cloud Center of Excellence (CCoE) team.

**Q: What is the cloud security model of Adatum Deliveries?**  
A: Adatum Deliveries primarily relies on network isolation for their cloud security.

**Q: What is the internal IT knowledge and experience of Adatum Deliveries?**  
A: Adatum Deliveries has expert knowledge of on-premises workloads and some experience with Azure PaaS. However, they have gaps in knowledge of Azure-based containerized workloads and cloud-native apps. They also have little experience with Azure overall but are familiar with DevOps using GitHub Enterprise and Bicep.

## Current Workload

**Q: How many Azure subscriptions are in use for this workload?**  
A: The current workload and all environments (Production & Non-production) are deployed in a single shared subscription..

**Q: What is the current workload of Adatum Deliveries?**  
A: The current workload of Adatum Deliveries is SmartDelivery, which is their first and only cloud-native app onboarded to Azure. It is owned by the dedicated SmartDelivery development team and consists of a container-based backend and a web API-based front end.

**Q: What is the architecture of the current workload?**  
A: The current workload architecture is microservices-based, with containerized backend APIs hosted on an Azure Kubernetes Service (AKS) cluster. The web APIs for client access are deployed in an App Service Environment (ASE). The delivery data is stored in a Cosmos DB account with locally redundant backups.

**Q: How are the environments of the current workload deployed?**  
A: The current workload has a single-region deployment in France Central. There is isolation between production, staging, and development environments, with each environment using a matching set of compute and storage resources.

**Q: How is the networking set up for the current workload?**  
A: The networking for the current workload includes an ASE deployment accessible via Azure Front Door, an AKS cluster accessible via a jumpbox Azure VM and virtual network peering, a Cosmos DB account accessible via private endpoint only, an Azure Storage account accessible via private endpoint only, and an ACR instance accessible via a public endpoint.

**Q: What is the DevOps status of the current workload?**  
A: The development and staging environments are configured identically to the production environment but are not exposed to the public internet via Azure Front Door. CI/CD pipelines are hosted in GitHub Enterprise and automated using GitHub Actions and Bicep templates. AKS telemetry is collected using Azure Application Insights and stored in an Azure Storage account. It is also exported to a third-party security information and event management (SIEM) system. AKS configuration and troubleshooting are performed on an as-needed basis from the jumpbox Azure VM by the SmartDelivery team.
