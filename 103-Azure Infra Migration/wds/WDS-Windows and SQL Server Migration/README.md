# Building the business migration case with Windows Server and SQL Server

Tailspin Toys is a global manufacturer of children’s toys that was founded in 1957 with its global headquarters located in Milwaukee, WI. Their mission-critical workloads are currently hosted in an on-premises datacenter and are beginning a journey to modernize and migrate into the cloud using Microsoft Azure.

During the Envision Workshop, Kaylee Frye, CTO of Tailspin Toys, saw the value of digital transformation, adopting the Microsoft Azure cloud, and modernizing their infrastructure. She has already had the Technical Architects at Tailspin Toys begin assessing their current environment and what it will take to migrate to the cloud. They are looking to optimize their technology investments by reducing technical debt, streamlining operations, and simplifying their DevOps workflow. According to Kaylee Frye, "Our development teams have already begun adopting DevOps strategies and implemented CI/CD (continuous integration and continuous delivery) pipelines with Azure DevOps. We really look forward to better streamlining IT operations as we adopt Microsoft Azure for the infrastructure too."

October 2022

## Target audience

- Enterprise Architects
- Infrastructure Engineers

## Abstracts

### Workshop

In this workshop, you will gain experience designing and implementing a strategy for migrating Windows Server and SQL Server workloads to Azure, and enabling on-premises virtual machines management by using Azure Arc.

At the end of the workshop, you will be better able to design and implement an Azure migration strategy for Windows Server and SQL Server workloads using Azure Virtual Machines, Azure SQL Managed Instance (SQL MI), and Azure Arc.

### Whiteboard Design Session

In this whiteboard design session, you will learn to design a strategy for migrating existing on-premises Windows Server and SQL Server workloads to Azure. Throughout the whiteboard design session, you will look at the virtual machine (VM) pricing, integrated management of cloud, and on-premises workloads using Azure Arc, and migrating SQL Server workloads to Azure.

At the end of the whiteboard design session, you will be better able to design a migration strategy for Windows Server workloads to Azure VMs, SQL Server workloads to Azure SQL Managed Instance (SQL MI), and simplify workload management using Azure Arc.

Continue to the [Whiteboard design session](Whiteboard%20design%20session) documents folder.

### Hands-on Lab

In this lab, attendees will perform steps toward migrating Tailspin Toy's on-premises Windows Server and SQL Server workloads to Azure. Tailspin needs a new Windows Server VM created in Azure for hosting their Web application, an on-premises SQL Server database migrated to Azure SQL Managed Instance, and an on-premises Windows Server VM to be Azure Arc-enabled.

Tailspin already has a Hub and Spoke network setup in Azure with Azure Bastion for enabling remote management of Azure VM using Azure Bastion. The Azure resources provisioned throughout this lab will be deployed into this environment.

At the end of this hands-on lab, you will be better able to set up a Windows Server for application migration to Azure, migrate an on-premises SQL Database to Azure SQL Managed Instance, and Azure Arc-enable an on-premises virtual machine so it can be managed from Azure.

Continue to the [Hands-on lab](Hands-on%20lab) documents folder.

## Azure services and related products

- Azure VMs
- Azure Arc
- Azure SQL Managed Instance
- Azure Networking
- Microsoft Data Migration Assistant
- Azure Data Studio - Azure SQL Migration Extension

## Azure solutions

DC Migration

## Related references
- [MCW](https://github.com/Microsoft/MCW)
- [Azure Arc](https://docs.microsoft.com/azure/azure-arc/overview)
- [Azure SQL Managed Instance](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview)

## Help & Support

We welcome feedback and comments from Microsoft SMEs & learning partners who deliver MCWs.  

***Having trouble?***
- First, verify you have followed all written lab instructions (including the Before the Hands-on lab document).
- Next, submit an issue with a detailed description of the problem.
- Do not submit pull requests. Our content authors will make all changes and submit pull requests for approval.

If you are planning to present a workshop, *review and test the materials early*! We recommend at least two weeks prior.

### Please allow 5 - 10 business days for review and resolution of issues.
