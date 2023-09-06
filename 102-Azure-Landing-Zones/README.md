# Architecting for Success

# 102 - Azure Landing Zones

## Overview

Successful cloud adoption is built on the strong foundations of the Cloud Adoption Framework Ready methodology. But what the hack is an Azure landing zone?

Simply put, a landing zone is a multi-subscription Azure environment for hosting workloads, pre-provisioned through code. Out-of-the-box it accounts for scale, security, governance, networking, and identity. It  enables application migration, modernization, and innovation at enterprise-scale for all customers irrespective of size in Azure. This approach considers all platform resources that are required to support the customer's application portfolio and doesn't differentiate between infrastructure as a service or platform as a service.

Watch this [short video](https://www.youtube.com/watch?v=VTnqUDMchXA) to learn more.
![Azure Landing Zone Conceptual Architecture](/102-Azure-Landing-Zones/images/alz_accelerator.png)

---

# About this module

In this module, you will learn how to **make design decisions and deploy the Azure landing zone conceptual architecture** using either the Azure Portal experience or the Bicep Accelerator. You will get familiar with the design areas and design principles of Azure Landing Zones. At the end of this module, you will be able to understand how to leverage the existing reference implementations as well as how to establish policy-driven governance.

---

## Prerequisites

Please read this [customer case study](/102-azure-landing-zones/challenges/readme.md). For the hands-on hackathon, review the requirements listed [here](./requirements.md). Note that this is a Bring-Your-Own-Subscription event; no Azure subscriptions will be provided.

---

## 1-day WDS Agenda

- Cloud Adoption and Well Architected Knowledge Refresh
- Azure Landing Zones and the Azure Landing Zone conceptual architecture review
- Contoso Corporation customer scenario review and discussion
- [Challenge 01](./wds/student%20guide/wds%20student%20guide%20-%20azure%20landing%20zones.md) Azure Landing Zones Design

---

## 3-day Hackathon Agenda

### Hackathon Day 1 (4hr)

- Cloud Adoption and Well Architected Knowledge Refresh
- Azure Landing Zones and the Azure Landing Zone conceptual architecture review
- Contoso Corporation customer scenario review and discussion
- The minified version of design areas, principles, considerations, and recommendations
- [Challenge 01](./challenges/challenge1.md) Azure Landing Zones deployment

### Hackathon Day 2 (7hr)

- The minified version of design areas, principles, considerations, and recommendations (cont.)
- [Challenge 01](./challenges/challenge1.md) Azure Landing Zones deployment (cont.)
- [Challenge 02](./challenges/challenge2.md) IaC and PaC with GitHub actions

### Hackathon Day 3 (7hr)

- [Challenge 03](./challenges/challenge3.md) Azure VM and Azure SQL Database BCDR at scale
- [Challenge 04](./challenges/challenge4.md) Documenting & Assessing ALZ
- [Challenge 05](./challenges/challenge5.md) Assessing Landing Zones just like the FTA team!
- [Challenge 06](./challenges/challenge6.md) Environment cleanup
