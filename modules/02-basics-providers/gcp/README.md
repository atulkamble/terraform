# Google Cloud provider lab — Storage bucket

Creates a standard storage bucket in a Google Cloud project. Storage, operations, and egress can incur charges. The bucket name must be globally unique.

Authenticate with Application Default Credentials, select a sandbox project, and ensure billing budgets are configured:
```bash
gcloud auth application-default login
gcloud config set project YOUR_SANDBOX_PROJECT_ID
gcloud config get-value project
cd modules/02-basics-providers/gcp
terraform init
terraform fmt
terraform validate
terraform plan -var="project_id=YOUR_SANDBOX_PROJECT_ID" -var="bucket_name=atul-terraform-lab-REPLACE-UNIQUE"
terraform apply -var="project_id=YOUR_SANDBOX_PROJECT_ID" -var="bucket_name=atul-terraform-lab-REPLACE-UNIQUE"
terraform destroy -var="project_id=YOUR_SANDBOX_PROJECT_ID" -var="bucket_name=atul-terraform-lab-REPLACE-UNIQUE"
```
