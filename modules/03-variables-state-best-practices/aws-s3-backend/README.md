# Remote backend pattern — AWS S3

This is a **reference snippet**, not a ready-to-apply setup. Create and secure the backend bucket and any required lock mechanism through a separate, reviewed bootstrap process before using this backend. Backend blocks cannot use normal Terraform variables.

Backend security checklist:

- Enable bucket versioning and server-side encryption.
- Block all public access; restrict IAM access to the Terraform operators/workload.
- Use a unique bucket and state key per independent state.
- Enable and verify locking according to the backend/provider version in use.
- Keep credentials out of backend configuration and source control.
- Understand recovery, retention, and state migration before changing backend settings.

Example backend block for a separate configuration:
```hcl
terraform {
  backend "s3" {
    bucket       = "REPLACE-WITH-SECURED-STATE-BUCKET"
    key          = "training/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
```
The S3 backend's locking options and syntax depend on the Terraform version; check current official documentation before deployment. Initialize or migrate state only after reviewing the migration prompt and backing up existing state.
