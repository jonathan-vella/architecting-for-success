# Azure Landing Zones for OpenAI (works in progress)

![Azure AI Landing Zone](./images/AIArchitecture.png "Azure AI Landing Zone")

This GitHub repository (which is based on the amazing work done by @FreddyAyala) provides a challenge-based workshop which will allow you to design an Azure AI Landing Zone — a tailored environment which will allow customers to accelerate their adoption of OpenAI services like GPT-4 and DALL-E.

**Optionally** This landing zone can also be designed to complement and integrate with existing data management and data landing zones within the [cloud-scale data analytics](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/) platform, enabling customers to unlock the true potential of their data thru AI.

---

## Customer Needs

Customers exploring Azure OpenAI services like GPT-4 and DALL-E have the following needs:

- Private: OpenAI services and other supporting services must be deployed in their own tenant.
- Compliant: Data must only reside in the regions which they specify.
- Isolated: Network traffic must be isolated from other services but still be able to easily connect to other internal services hosted either in Azure or on-premises.
- Secure: Use built-in enterprise grade authentication security features.
- Resilient: Deploy services across multiple regions to ensure high availability and disaster recovery.
- Consumer Friendly: Provide a familiar user experience and the added capabilities of chatting over the internet.

---

## Whiteboard Design Session

The whiteboard design session is based on a fictitious customer called InnovateWear. InnovateWear is a clothing manufacturer that is looking to use AI to improve their customer experience. They want to use Azure OpenAI services to build a chatbot that will help customers find the right clothing for them. You can find the customer story [here](./docs/innovatewear-alz-for-ai-customer-scenario.md).

---

## Azure Chat Solution Accelerator powered by Azure Open AI

In the hands-on part of this workshop we will be using the [Azure Chat Solution Accelerator](https://github.com/microsoft/azurechat/tree/main) to deploy a private Azure OpenAI powered chatbot in your Azure Subscription, with a familiar user experience and the added capabilities of chatting over your data and files.

### 📘 Prerequisites

Please make sure the following prerequisites are in place prior to deploying this accelerator:

1. [Azure OpenAI](https://azure.microsoft.com/en-us/products/cognitive-services/openai-service/): To deploy and run the solution accelerator, you'll need an Azure subscription with access to the Azure OpenAI service. Request access [here](https://customervoice.microsoft.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR7en2Ais5pxKtso_Pz4b1_xUOFA5Qk1UWDRBMjg0WFhPMkIzTzhKQ1dWNyQlQCN0PWcu). Once you have access, follow the instructions in this [link](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/create-resource?pivots=web-portal) to deploy the gpt-35-turbo or gpt-4 models.

2. Setup GitHub or Azure AD for Authentication:
   The [add an identity provider](./5-add-identity.md) section below shows how to configure authentication providers.

   > **Note**
   > You can configure the authentication provider to your identity solution using [NextAuth providers](https://next-auth.js.org/providers/)
