# Architecting for Success -  Infographic for common scenarios

_Kubernetes Architecture_

> **Note**: This reference implementation demonstrates the *recommended starting (baseline) infrastructure architecture* for an AKS cluster that is under regulatory compliance requirements (such as PCI). This implementation builds directly upon the [AKS Baseline Cluster reference implementation](https://github.com/mspnp/aks-baseline) and adds to it additional implementation points that are more commonly seen in regulated environments vs typical "public cloud" consumption patterns.The reference architecture and implementation have not been certified by an official authority. By completing this series and deploying the code assets, you do not clear audit for PCI DSS. Acquire compliance attestations from third-party auditor.

[<img src="../../images/regulated-architecture.svg" width="600"/>](../../images/regulated-architecture.svg)

<https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-pci/aks-pci-ra-code-assets>

_Workload HTTPS request flow_

[<img src="../../images/flow.svg" width="600"/>](../../images/flow.svg)

<https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-pci/aks-pci-ra-code-assets#tls-encryption>

_Use GitOps with Flux, GitHub, and AKS to implement CI/CD_

[<img src="../../images/gitops-ci-cd-flux.png" width="600"/>](../../images/gitops-ci-cd-flux.png)

<https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks#scenario-2-use-gitops-with-flux-github-and-aks-to-implement-cicd>