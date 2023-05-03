![](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/main/Media/ms-cloud-workshop.png "Microsoft Cloud Workshops")

<div class="MCWHeader1">
Building the business migration case with Linux and OSS DB to Azure
</div>

<div class="MCWHeader2">
Whiteboard design session student guide
</div>

<div class="MCWHeader3">
December 2022
</div>

Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2022 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**

<!-- TOC -->

- [Building the business migration case with Linux and OSS DB to Azure whiteboard design session student guide](#building-the-business-migration-case-with-linux-and-oss-db-to-azure-whiteboard-design-session-student-guide)
    - [Abstract and learning objectives](#abstract-and-learning-objectives)
    - [Step 1: Review the customer case study](#step-1-review-the-customer-case-study)
        - [Customer situation](#customer-situation)
        - [Customer needs](#customer-needs)
        - [Customer objections](#customer-objections)
        - [Infographic for common scenarios](#infographic-for-common-scenarios)
    - [Step 2: Design a proof of concept solution](#step-2-design-a-proof-of-concept-solution)
    - [Step 3: Present the solution](#step-3-present-the-solution)
    - [Wrap-up](#wrap-up)
    - [Additional references](#additional-references)

<!-- /TOC -->

# Building the business migration case with Linux and OSS DB to Azure whiteboard design session student guide

## Abstract and learning objectives

In this whiteboard design session, you will learn to design a strategy for migrating existing on-premises Red Hat Enterprise Linux (RHEL) and MySQL database workloads to Azure. Throughout the whiteboard design session, you will look at the virtual machine (VM) pricing and migrating MySQL database workloads to Azure.

At the end of the workshop, you will be better able to design a migration strategy for Red Hat Enterprise Linux (RHEL) workloads to Azure VMs and MySQL database workloads to Azure Database for MySQL.

## Step 1: Review the customer case study

**Outcome**

Analyze your customer's needs.

Timeframe: 15 minutes

Directions: With all participants in the session, the facilitator/SME presents an overview of the customer case study along with technical tips.

1. Meet your team members and trainer.

2. Read all directions for steps 1-3 in the student guide.

3. As a team, review the following customer case study.

### Customer situation

Terra Firm Laboratories is a global bioengineering company that’s the leading researcher and innovator in genetic and biological science technology. The company was founded in 1975 with its corporate headquarters in Palo Alto, CA. Their mission-critical workloads are currently hosted in an on-premises datacenter and are beginning a journey to modernize and migrate into the cloud using Microsoft Azure.

The CTO, Dennis Nedry, has kicked off an initiative for the organization to begin adopting the Microsoft Azure cloud and modernize its infrastructure. He has already had his team begin assessing their current environment and what it will take to migrate to the cloud. They are looking to optimize their technology investments by reducing technical debt and streamlining operations using Azure Infrastructure-as-a-Service (IaaS) and Platform-as-a-Service (PaaS) cloud services.

Terra Firm Laboratories has already completed the first round of analysis to identify the applications and workloads to begin migrating first. Out of over 250 workloads they have running on-premises, they have identified one workload that exemplifies multiple components common across many of their other workloads. They decided to use a simpler workload that will still assist in proving out the migration plan as it’s developed. This workload includes Red Hat Enterprise Linux (RHEL) servers hosting a Web application that uses a MySQL backend database.

The initial workload to prove the feasibility of the migration process consists of the following:

- Web application front-end
    - PHP web application hosted using Apache HTTP web server.
    - 2x Red Hat Enterprise Linux 9 servers
        - Each with 2 CPU cores and 16 GB memory
- Application databases
    - MySQL 8
    - 2x server with data replication
        - Each with 4 CPU cores and 32 GB memory
    - Database size: 500 MB

The development standards that Terra Firm has established include DevOps automation to deploy the web application code to the front-end servers. They also use Git for version control for all their development teams.

This initial workload utilizes components that represent those used by most of their workloads throughout the on-premises datacenter. in their on-premises datacenter. They need to start with creating a migration plan around this workload to prove the larger overall strategy that will be implemented. According to Nedry, “It’s really important we have a solid migration plan, as we will be sunsetting our on-premises datacenter in the next 2 to 3 years.”

### Customer needs

1. Migrate existing workloads to Azure as efficiently as possible.

2. Security is extremely important when integrating the on-premises network and workloads with Microsoft Azure.

3. Improve the business continuity and disaster recovery position of the workloads that are migrated to Azure.

### Customer objections

1. What are the options to roll back to the on-premises VMs if the migration fails?

2. What options does Azure provide for utilizing existing Red Hat Subscription to save on Red Hat Enterprise Linux (RHEL) VM cost in the cloud?

3. Securing and monitoring our on-premises workloads is extremely important. What options does Azure offer to extend this into the cloud?

4. What options are there for PaaS hosting in Azure, and would they offer additional cost savings?

### Infographic for common scenarios

**Hub-spoke network topology in Azure**
![The image shows how the on-premises network on the left connects through Azure ExpressRoute to the Hub VNet with Azure Bastion and Azure Firewall. On the right are multiple Spoke VNet that connect to the Hub VNet through VNet Peering and hosts multiple VM workloads.](images/diagram-azure-vnet-hub-spoke.png "Hub-spoke network topology in Azure")

## Step 2: Design a proof of concept solution

**Outcome**

Design a solution and prepare to present the solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 60 minutes

**Business needs**

Directions: With your team, answer the following questions and be prepared to present your solution to others:

1. Who will you present this solution to? Who is your target customer audience? Who are the decision makers?

2. What customer business needs do you need to address with your solution?

**Design**

Directions: With your team, respond to the following questions:

*Migration*

1. How will you migrate the on-premises PHP workloads to Azure?

2. How will you migrate the on-premise MySQL database workloads to Azure?

*Pricing*

1. What is the estimated cost for the workloads after being migrated to Azure IaaS?

    Be sure to cover all aspects of the design, including the primary site, disaster recovery (DR) solution, backup solution, and monitoring costs.

    What's the best option for hosting the MySQL database workloads?

    Have you included all appropriate cost-saving measures?

2. What is the estimated cost for the web application workloads if migrated to Azure PaaS?

    Be sure to cover all aspects of the design, including the primary site, disaster recovery (DR) solution, backup solution, and monitoring costs

    How does the cost of PaaS compare to IaaS?

**Prepare**

Directions: As a team:

1. Identify any customer needs that are not addressed with the proposed solution.

2. Identify the benefits of your solution.

3. Determine how you will respond to the customer's objections.

Prepare a 15-minute chalk-talk style presentation to the customer.

## Step 3: Present the solution

**Outcome**

Present a solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 30 minutes

**Presentation**

Directions:

1. Pair with another team.

2. One group is the Microsoft team, the other is the customer.

3. The Microsoft team presents their proposed solution to the customer.

4. The customer makes one of the objections from the list of objections.

5. The Microsoft team responds to the objection.

6. The customer team gives feedback to the Microsoft team.

7. Switch roles and repeat Steps 2-6.

## Wrap-up

Timeframe: 15 minutes

Directions: Reconvene with the larger group to hear the facilitator/SME share the preferred solution for the case study.

## Additional references

|    |            |
|----------|:-------------:|
| **Description** | **Links** |
| Microsoft Azure Reference Architectures| <https://docs.microsoft.com/azure/guidance/guidance-architecture> |
| What is Azure Database for MySQL? | <https://learn.microsoft.com/azure/mysql/single-server/overview> |
| Azure Database Migration Service | <https://azure.microsoft.com/products/database-migration/#overview> |
| Tutorial: Migrate MySQL to Azure Database for MySQL offline using DMS | <https://learn.microsoft.com/azure/dms/tutorial-mysql-azure-mysql-offline-portal> |
| Hub-spoke network topology in Azure | <https://learn.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/hub-spoke> |
| Private Network Access for Azure Database for MySQL - Flexible Server | <https://learn.microsoft.com/azure/mysql/flexible-server/concepts-networking-vnet> |
| Extend an on-premises network using ExpressRoute | <https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/expressroute> |
