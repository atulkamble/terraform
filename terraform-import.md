## Import an existing AWS EC2 instance

This uses the current AWS provider version and the classic `terraform import` command. Replace the example region and instance ID with yours.

### 1. Get your instance ID

```bash
aws ec2 describe-instances \
  --region ap-south-1 \
  --query 'Reservations[].Instances[].[InstanceId,State.Name]' \
  --output table
```

### 2. Create `main.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "practice" {}
```

### 3. Initialize and import

```bash
terraform init
terraform import aws_instance.practice i-0123456789abcdef0
```

The address `aws_instance.practice` must match the resource block. The ID is the EC2 instance ID.

### 4. Inspect and finish

```bash
terraform state show aws_instance.practice
terraform plan
```

Use the state output to fill in the resource settings in `main.tf`. Review the plan and adjust the configuration until it shows no unintended changes. Don’t apply until the plan is safe.

The import command records the instance in Terraform state; it does not generate the full configuration. 
