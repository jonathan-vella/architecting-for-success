# Azure Landing Zones for OpenAI

![Azure AI Landing Zone](AIArchitecture.png "Azure AI Landing Zone")

This GitHub repository provides a comprehensive guide to deploy an Azure AI Landing Zone—a specialized environment for empowering AI technologies, including advanced language models like GPT-4. The landing zone is designed to complement existing data management and data landing zones within your cloud-scale data analytics platform, enabling you to unlock the true potential of AI.

## Architecture Scenarios

### Scenario: Secure Communication to Azure App Service via Private Link

![Azure AI Landing Zone](AILZScenario2.png "Azure AI Landing Zone")

In this scenario, the user deploys a standard landing zone architecture to ensure a well-organized and secure Azure environment. The architecture includes the following components and steps:

* Standard Landing Zone: The deployment begins with setting up a standard Azure Landing Zone. This Landing Zone follows best practices and guidelines for organizing resources and aligning with security and compliance standards.

* Internal Network Access: Users can access an Azure App Service from within the internal network. To achieve this, a jumpbox or bastion host is used as an entry point to the Azure network. Users connect to the jumpbox securely, and from there, they can access other resources within the Azure network.

* Azure App Service with Private Link: The Azure App Service is configured to use a private link. This private link ensures that the web application is only accessible over a private network, enhancing security and minimizing exposure to the public internet.

* Azure OpenAI Integration: The web application deployed in the Azure App Service needs to connect to Azure OpenAI. To achieve secure communication, it uses a private endpoint for Azure OpenAI. Private endpoints allow services to be accessed privately within a virtual network, reducing exposure to the public internet.

* Firewall Rules for Azure OpenAI: Since the Azure App Service's outbound IP address is dynamic and public, it requires additional configuration on the Azure OpenAI side. Firewall rules are set up in Azure OpenAI to allow communication from the Azure App Service's dynamic IP address. This ensures that the web application can establish a secure connection with Azure OpenAI while maintaining a private and secure network architecture.

* Overall, this architecture scenario emphasizes security and isolation by utilizing private endpoints, restricting access to internal networks, and carefully managing communication between the Azure App Service and Azure OpenAI. It allows users to securely access the web application within the Azure network while ensuring that external connections are controlled and protected.

### Scenario: Securely Exposing the Application with Application Gateway and WAF

![Azure AI Landing Zone](AILZScenario1.png "Azure AI Landing Zone")

In this scenario, you build upon the architecture from the first scenario to securely expose your application to external users. The key components and steps are as follows:

* Standard Landing Zone: As in the previous scenario, you start with a standard Azure Landing Zone to ensure a well-organized and secure Azure environment.

* Internal Network Access via Jumpbox: Users can still access the Azure App Service from within the internal network through a jumpbox or bastion host, ensuring secure access to internal resources.

* Azure App Service with Private Link: Your Azure App Service continues to use a private link, maintaining a high level of security by allowing access only over a private network.

* Azure OpenAI Integration with Private Endpoint: The web application within the Azure App Service connects to Azure OpenAI via a private endpoint, ensuring secure and private communication.

* Application Gateway: In this scenario, you introduce an Azure Application Gateway. The Application Gateway acts as a reverse proxy, providing load balancing and traffic routing capabilities.

* Web Application Firewall (WAF): The Application Gateway is configured with a Web Application Firewall (WAF). The WAF provides security features such as protection against common web application attacks, like SQL injection and cross-site scripting (XSS) attacks. It helps safeguard your application against web-based threats.

* Securely Exposing the Application: The Application Gateway and WAF allow you to securely expose your web application to external users. Traffic from external users passes through the Application Gateway, which then routes it to the Azure App Service.

* Firewall Rules for Azure OpenAI: Similar to the first scenario, you maintain firewall rules in Azure OpenAI to allow communication from the dynamic IP address of the Azure App Service, ensuring secure access to Azure OpenAI resources.

This architecture enhances the security of your web application by adding a layer of protection through the Web Application Firewall (WAF) while still leveraging the benefits of private endpoints for Azure OpenAI. It provides a secure and controlled way to expose your application to external users while protecting it from common web-based threats.

## Features

## Enterprise Landing Zone
### Hub and Azure Firewall Deployment
- Automated deployment of a Hub network and Azure Firewall using the Azure Terraform landing zone standard module.
- Enhances security and network architecture within the landing zone.

### Sample Configuration with Azure Firewall
- Provides users with readily available sample configurations for setting up the hub network, including Azure Firewall settings.
- Simplifies the initial configuration process.

### Example Firewall Policies
- Features a set of example firewall policies for securing and managing traffic within the landing zone.
- Predefined security policies are available for improved network protection.

### Workbook for Firewall Traffic Monitoring
- Deploys workbooks inside the Azure Firewall to have comprehensive monitoring and analysis of all traffic secured by the firewall.

### Private DNS Zones Automation
- Automates the deployment of private DNS zones, facilitating domain name resolution within the landing zone.
- DNS Resolver deployed and integrated with Private DNS Zones for centralized DNS resolved from and to on prem and in azure as well.
  
### DNS Policy Example
- Demonstrates a policy example that automatically adds DNS entries to the private DNS zone for private endpoints in the hub.
- Simplifies Private DNS management and configuration.

### Core Resource and Management Groups Alignment with CAF
- Aligns the deployment with the Cloud Adoption Framework (CAF) guidelines.
- Establishes a structured and organized resource hierarchy.

### Custom Azure Policies
- Configures custom Azure policies to allow specific resource creation, such as audit VNets without Network Security Groups (NSGs).
- Maintains security and compliance while providing flexibility.

### Monitoring and Logs Resources Deployment
- Automates the deployment of resources necessary for monitoring and logging within the landing zone, Azure Monitor, Log Analytics, diagnostic settings, etc.
- Enhances visibility and compliance tracking.

### Independent Module Deployment
- Enables users to deploy each module independently using orchestration tools or scripts.
- Promotes modularity and flexibility in configuration.

### Azure Bastion and Jumpbox
- Deploys Azure Bastion and Jumpbox solutions for secure access to private resources within the landing zone.
- Enhances remote access and security for administrators.

## AI Landing Zone - Features

### Sample Private GPT Web Application
- A sample web application that connects to OpenAI and utilizes CosmosDB for storing conversation history.
- Provides the ability to connect to Cognitive Search for using custom indexed data.

### Linux Web App Deployment
- Deploys the web application inside a Linux web app using Azure App Service.
- Ensures a scalable and reliable hosting environment.

### Private Link for OpenAI Service
- Establishes a Private Link for the OpenAI service.
- Implements firewalling rules to allow secure communication between the web app and OpenAI.
  
### Application Gateway and WAF Deployment
- Deploys an Application Gateway with Web Application Firewall (WAF) to securely expose your chat web app to the internet.
- Enhances security and protection against common web application attacks.

### Azure API Management (APIM) Integration (Work in Progress)
- Integration with Azure API Management (APIM) is in progress, allowing for comprehensive API management and monitoring.

### Routing and VNET Integration
- Establishes routing and integrates with Virtual Network (VNET) for secure communication and isolation.
- Utilizes Network Security Groups (NSGs) to control traffic and enhance network security.

### Integration with Main Landing Zone
- Integrates seamlessly with the main landing zone using network peering.
- Provides a consistent and cohesive infrastructure for AI workloads within the broader Azure environment.
