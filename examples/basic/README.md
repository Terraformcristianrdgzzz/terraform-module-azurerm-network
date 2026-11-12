# Basic network example

This example calls the network module from the local repository path. It creates a virtual network and subnet in an **existing** resource group.

Copy `terraform.tfvars.example` to `terraform.tfvars`, then update the resource group, region, and CIDR ranges. Review the plan before applying; this example creates billable Azure resources.

```powershell
terraform init
terraform fmt -check
terraform validate
terraform plan
```

Apply only after reviewing the plan and confirming the target subscription:

```powershell
terraform apply
```
