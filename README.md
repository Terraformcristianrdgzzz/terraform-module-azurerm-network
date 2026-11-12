# terraform-module-azurerm-network

A reusable Terraform module that creates an Azure virtual network and one subnet in an existing resource group.

The module does not create the resource group, configure a Terraform backend, or assign Azure RBAC roles. Those concerns belong to the calling deployment configuration and its setup.

## Architecture

```text
Existing Resource Group
└── Virtual Network
    └── Subnet
```

## Requirements

| Name | Version |
| --- | --- |
| Terraform | >= 1.5.0 |
| AzureRM provider | >= 4.0.0, < 5.0.0 |

The calling root configuration must configure the AzureRM provider and authentication.

## Usage

```hcl
module "network" {
  source = "git::https://github.com/Terraformcristianrdgzzz/terraform-module-azurerm-network.git?ref=v0.1.0"

  resource_group_name = "rg-terraformdeployments-stage"
  location            = "East US"

  vnet_name          = "vnet-stage"
  vnet_address_space = ["10.10.0.0/16"]

  subnet_name     = "snet-web"
  subnet_prefixes = ["10.10.1.0/24"]
}
```

The `v0.1.0` tag is published in this repository. Pin consumers to a published tag rather than the moving `main` branch.

## Examples and tests

- [`examples/basic`](./examples/basic) shows a root configuration that calls this module and can be planned or applied to Azure.
- [`tests/network.tftest.hcl`](./tests/network.tftest.hcl) checks outputs and CIDR validation using a mocked AzureRM provider. Tests do not create Azure resources.

Run the unit tests with Terraform 1.7.0 or later:

```shell
terraform init -backend=false
terraform test
```

Terraform's mocked-provider test support requires 1.7.0 or later. The module itself remains compatible with Terraform 1.5.0 and later.

## Inputs

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| `resource_group_name` | Name of the existing resource group for the network resources. | `string` | yes |
| `location` | Azure region for the virtual network. | `string` | yes |
| `vnet_name` | Name of the virtual network. | `string` | yes |
| `vnet_address_space` | One or more IPv4 CIDR address spaces for the virtual network. | `list(string)` | yes |
| `subnet_name` | Name of the subnet. | `string` | yes |
| `subnet_prefixes` | One or more IPv4 CIDR address prefixes for the subnet. | `list(string)` | yes |

CIDR inputs are checked for valid IPv4 CIDR notation. Choose subnet ranges that fit inside the virtual network address space and do not overlap other networks; the module does not discover or validate ranges used elsewhere in Azure.

## Outputs

| Name | Description |
| --- | --- |
| `resource_group_name` | Name of the resource group containing the network resources. |
| `vnet_id` | ID of the virtual network. |
| `vnet_name` | Name of the virtual network. |
| `subnet_id` | ID of the subnet. |
| `subnet_name` | Name of the subnet. |

The web server module can use `module.network.subnet_id` to attach its network interface to this subnet.

## Versioning

Use semantic version tags and reference a specific tag from consumers instead of depending on the moving `main` branch.

## License

MIT
