# AWS provider lab — S3 bucket

Creates a uniquely named, private S3 bucket with public access blocked. S3 storage and requests can incur charges. Use a disposable bucket name and destroy after practice.

## Authenticate

Install/configure AWS CLI, then authenticate using a profile or role. Example profile setup is interactive:
```bash
aws configure --profile terraform-lab
export AWS_PROFILE=terraform-lab
aws sts get-caller-identity
```
Do not commit credentials. Use an account with only the required permissions and an applicable budget.

## Run

```bash
cd modules/02-basics-providers/aws
terraform init
terraform fmt
terraform validate
terraform plan -var="bucket_name=atul-terraform-lab-REPLACE-UNIQUE"
terraform apply -var="bucket_name=atul-terraform-lab-REPLACE-UNIQUE"
terraform output
terraform destroy -var="bucket_name=atul-terraform-lab-REPLACE-UNIQUE"
```
S3 bucket names are globally unique. Replace the example suffix with a unique value. Empty the bucket before destroy if you add objects.
