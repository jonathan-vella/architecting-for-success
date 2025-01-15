# Architecting for Success: AI-Ready Azure Landing Zones

## Whiteboard Design Session

## Abstract and learning objectives

In this whiteboard design session, you will learn to design an Azure Landing Zones architecture for Contoso. You will be working through the customer scenario and their particular requirements to produce a tailored architecture for their Azure Landing Zone deployment.

---

## Step 1: Review the [customer case study](./../docs/contoso-alz-customer-scenario.md)

**Outcome** Analyze your customer's needs.

Timeframe: 15 minutes

Directions: With all participants in the session, the facilitator/SME presents an overview of the customer case study along with technical tips.

1. Meet your team members and trainer.

2. Read all directions for steps 1-3 in the student guide.

3. As a team, review the customer case study.

### Infographic for common scenarios

**Azure Landing Zones conceptual architecture**
![For many organizations, the ALZ conceptual architecture below represents the destination in their cloud adoption journey. It's a mature, scaled-out target architecture intended to help organizations operate successful cloud environments that drive their business while maintaining best practices for security and governance.](./../images/alz_accelerator.png)

---

## Step 2: Design a proof of concept solution

**Outcome**
Design a solution and prepare to present the solution to the target customer audience in a 10-minute chalk-talk format.

Timeframe: 90 minutes

Your design must include a solution for all of the following:

- An Azure environment which is ready to securely and efficiently host Azure AI related workloads.
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

When designing your solution, you need to document the following:

1. Details about minimum requirements and information you need have at hand to deploy Azure Landing Zones. Think of tenants, subscriptions, privileged identities, security contacts, IP addresses, etc.
2. A management group hierarchy including subscription & resource organization.
3. A network topology diagram.
4. Azure Policy assignments.
5. A list of RBAC assignments.

---

## Step 3: Present the solution

**Outcome**
Present a solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 15 minutes

**Presentation**
Directions:

1. Pair with another team.
2. One group is the Microsoft team, the other is the customer.
3. The Microsoft team presents their proposed solution to the customer.
4. The customer is expected to make one objections.
5. The Microsoft team responds to the objection.
6. The customer team gives feedback to the Microsoft team.