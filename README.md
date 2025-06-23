### Copilot Studio OpsBot
Demo how to use confluence as a knowledge source for network operations Q&A
![OpsBot-1](./images/OpsBot-1.jpg)
![OpsBot-2](./images/OpsBot-2.jpg)
![OpsBot-3](./images/OpsBot-3.jpg)

### Copilot Studio MCP
Demo how to connect to MCP servers to book meeting and tell a joke
![MCP-1](./images/MCP-1.jpg)
![MCP-2](./images/MCP-2.jpg)
![MCP-3](./images/MCP-3.jpg)

### Copilot Studio Agent Flows
Showcase how agent flows can streamline ticket creation and automate responses with commonly used solutions.
![Copilot-Studio-AutoIT](./images/Copilot-Studio-AutoIT.jpg)
![Copilot-Studio-AutoIT-Email](./images/Copilot-Studio-AutoIT-Email.jpg)

### Azure MCP
Start MCP server from mcp.json file.
```
Please generate a Mermaid diagram that provides an overview of all my currently deployed resources.
```

### Github Copilot Custom Chat Mode

#### Network Operations Planning
By leveraging the custom chat mode in Github Copilot, you can create a more interactive and tailored experience for network operations planning. Here’s how you can use it:

```
Please review my current Azure network resources and provide recommendations for a more optimized and cost-effective network architecture.
```
![Github-Copilot-CustomChatMode](./images/Github-Copilot-CustomChatMode.jpg)

#### Azure Terraform Script Generation
You can use the custom chat mode to generate Terraform scripts for Azure resources. Here’s an example of how to do this:
```
Based on the azure-arch.png image, please generate terraform deployment script
```
![Github-Copilot-Terraform](./images/Github-Copilot-Terraform.jpg)

### Github Copilot Coding Agent
Use Github Copilot to generate Azure Terraform scripts and GitHub workflows for automating resource provisioning based on the provided architecture diagram.

```
Based on below mermaid diagram, develop Azure Terraform deployment scripts and GitHub workflows to automate resource provisioning.
```

```mermaid
flowchart LR
    subgraph AKS["Azure Kubernetes Service (AKS)"]
        subgraph FrontEnd["Front end"]
            Ingress["Ingress (Nginx)"]
        end
        subgraph BackEnd["Back-end services"]
            BE1["Service 1"]
            BE2["Service 2"]
            BE3["Service 3 (Pod autoscaling)"]
        end
        subgraph Utility["Utility services"]
            Elasticsearch["Elasticsearch"]
            Prometheus["Prometheus"]
        end
    end

    ClientApps["Client Apps"]
    LoadBalancer["Azure Load Balancer"]
    GithubWorkflows["Github Workflows (CI/CD)"]
    Helm["Helm"]
    ContainerRegistry["Container Registry"]
    DevOps["Dev/Ops"]
    AAD["Azure Active Directory"]
    Monitor["Monitor"]
    KeyVault["Azure Key Vault"]
    SQL["SQL Database"]
    CosmosDB["Cosmos DB"]

    ClientApps --> LoadBalancer
    LoadBalancer --> Ingress
    Ingress --> BE1
    Ingress --> BE2
    Ingress --> BE3
    BE1 --> SQL
    BE2 --> CosmosDB
    BE3 -.-> CosmosDB
    Utility --> Elasticsearch
    Utility --> Prometheus

    GithubWorkflows -- docker push/pull --> ContainerRegistry
    GithubWorkflows -- helm upgrade --> Helm
    Helm --> AKS
    DevOps -->|RBAC| AAD
    AKS -.->|Virtual network| Monitor
    AKS -.->|Virtual network| KeyVault
```
[Task: Develop Azure Terraform deployment scripts and GitHub workflows to automate resource provisioning](https://github.com/huangyingting/CopilotX/issues/1)

### Azure SRE Agent
Azure SRE Agent brings these principles to your Azure hosted applications by providing an AI-powered tool that helps sustain production cloud environments.
