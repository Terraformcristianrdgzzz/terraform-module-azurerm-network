# terraform-azurerm-network

Terraform module to deploy a basic Azure networking foundation, including:

- Resource Group (optional)
- Virtual Network (VNet)
- Subnet

This module is intended for learning purposes and reusable deployments across multiple environments such as **stage** and **prod**.

## Architecture

```text
Resource Group
└── Virtual Network
    └── Subnet
```

## Requirements

| Name | Version |
|--------|---------|
| Terraform | >= 1.0.0 |
| AzureRM Provider | ~> 3.0 |

## Usage

```hcl
module "network" {
  source = "git::https://github.com/cristianrdgzzz/terraform-azurerm-network.git?ref=v0.1.0"

  resource_group_name = "rg-terraformdeployments-stage"
  location            = "westeurope"

  vnet_name           = "vnet-stage"
  vnet_address_space  = ["10.0.0.0/16"]

  subnet_name         = "subnet-web"
  subnet_prefixes     = ["10.0.1.0/24"]
}
```

## Inputs

| Name | Description | Type | Required |
|--------|------------|------|---------|
| resource_group_name | Name of the Resource Group | string | Yes |
| location | Azure region | string | Yes |
| vnet_name | Virtual Network name | string | Yes |
| vnet_address_space | VNet address space | list(string) | Yes |
| subnet_name | Subnet name | string | Yes |
| subnet_prefixes | Subnet address prefixes | list(string) | Yes |

## Outputs

| Name | Description |
|--------|------------|
| resource_group_name | Resource Group name |
| vnet_id | Virtual Network ID |
| vnet_name | Virtual Network name |
| subnet_id | Subnet ID |
| subnet_name | Subnet name |

## Example

```hcl
module "network" {
  source = "git::https://github.com/cristianrdgzzz/terraform-azurerm-network.git?ref=v0.1.0"

  resource_group_name = "rg-terraformdeployments-prod"
  location            = "westeurope"

  vnet_name           = "vnet-prod"
  vnet_address_space  = ["10.1.0.0/16"]

  subnet_name         = "subnet-web"
  subnet_prefixes     = ["10.1.1.0/24"]
}
```

## Versioning

This module follows Semantic Versioning.

Examples:

- v0.1.0 → Initial release
- v0.2.0 → New features
- v1.0.0 → Stable production release

Always reference a specific version tag instead of the `main` branch:

```hcl
source = "git::https://github.com/cristianrdgzzz/terraform-azurerm-network.git?ref=v0.1.0"
```

## Security Notes

- Use non-overlapping CIDR ranges between environments.
- Follow the principle of least privilege when assigning Azure RBAC permissions.
- Validate network ranges before deployment to avoid address conflicts.
- Review resources before applying changes in production environments.

## License

MIT License
