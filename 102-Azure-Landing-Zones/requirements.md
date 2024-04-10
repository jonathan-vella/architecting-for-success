## Azure subscription requirements

- This is a Bring-Your-Own-Subscription event; no Azure subscriptions will be provided.
- At least 1 Azure subscription and 1 Entra ID tenant per attendee are required; the recommendation is to have 2 Azure subscriptions and 1 Entra ID tenant per attendee.
- All subscriptions should be associated to a **non-production Entra ID tenant**.
- [Tenant root access](https://github.com/Azure/Enterprise-Scale/wiki/Deploying-ALZ-Pre-requisites) is a mandatory requirement for this hackathon.

---

## Tooling pre-requisites

To avoid any delays with downloading or installing tooling, have the following ready prior to attending:

- A GitHub account.

- A modern laptop running the latest version of Window 11, Mac OS X or Ubuntu 22.

- Install your choice of Integrated Development Environment (IDE) software such as [Visual Studio Code](https://code.visualstudio.com/download)

- Download of the latest version of PowerShell 7, Az. PowerShell Modules, and [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

- Make sure that the modules below are installed:
  
  ```powershell
  Install-Module Az.Accounts, Az.Resources, Microsoft.Graph.Identity.DirectoryManagement, Microsoft.Graph.Applications
  ```

- If you need to update them you can execute the following command:
  
  ```powershell
  Update-Module Az.Accounts, Az.Resources, Microsoft.Graph.Identity.DirectoryManagement, Microsoft.Graph.Applications
  ```

## Required knowledge

- [Microsoft Cloud Adoption Framework for Azure module on MS Learn](https://learn.microsoft.com/en-us/training/modules/microsoft-cloud-adoption-framework-for-azure/) (50min)
- [Introduction to the Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/en-us/training/modules/azure-well-architected-introduction/) (1hr)
- [Fundamental knowledge of Azure Networking]((https://learn.microsoft.com/en-us/training/paths/intro-to-azure-network-foundation-services/) (5hr)
- View [Azure Master Class v2 Mod. 3 Governance](https://www.youtube.com/watch?v=mluS8ovuBKg) (2hrs)
- View [Azure Landing Zones Overview](https://www.youtube.com/watch?v=eLSjnF6Crlw) (45min)
