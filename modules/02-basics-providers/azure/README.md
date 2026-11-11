# Azure provider lab — Resource Group

Creates one resource group. Azure resources deployed into it can incur charges; the group itself is a container. Authenticate with Azure CLI and destroy the group when finished.

```bash
az login
az account show
cd modules/02-basics-providers/azure
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```
Select the intended subscription before applying: `az account set --subscription "<subscription-id>"`. Review the plan and confirm the resource group name/location are appropriate.
