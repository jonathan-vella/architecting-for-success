# Architecting for Success

## 102 - Azure Landing Zones

### Azure subscription requirements

- This is a Bring-Your-Own-Subscription event; no Azure subscriptions will be provided.
- At least 1 Azure subscription and 1 AAD tenant per attendee are required; the recommendation is to have 2 Azure subscriptions and 1 AAD tenant per attendee.
- All subscriptions should be associated to a **non-production AAD tenant**.
- [Tenant root access](https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin) is a mandatory requirement for this hackathon.

> Note: Azure subscriptions in CSP must have Azure Cost Management enabled as per this [document](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/get-started-partners)

---

### Tooling Prerequisites

To avoid any delays with downloading or installing tooling, have the following ready prior to attending:

- A GitHub account.

- A modern laptop running the latest version of either Windows 10 or Window 11, Mac OS X 10.13 or higher, or Ubuntu 18.04 pr higher.

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
