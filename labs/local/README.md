# Lab 1 — First Terraform configuration (local only)

This lab creates a local file using the HashiCorp local provider. It requires no cloud account and does not create cloud resources.

## Linux and macOS

```bash
cd labs/local
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
cat example.txt
terraform destroy
```

## Windows PowerShell

```powershell
Set-Location labs/local
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
Get-Content .\example.txt
terraform destroy
```

Inspect the plan before confirming apply. The output file is ignored by Git.
