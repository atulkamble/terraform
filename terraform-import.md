## Terraform import practice

`terraform import` connects an **existing cloud resource** to a Terraform resource address in your configuration. It adds the resource to Terraform state; it does **not** write the resource’s configuration for you.

### Practice: import an existing AWS EC2 instance

Assume an EC2 instance already exists with ID `i-0123456789abcdef0`.

**1. Create a Terraform configuration** with a matching resource block:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "practice" {
  # Add the existing instance's settings here after import.
}
```

**2. Initialize Terraform:**

```bash
terraform init
```

**3. Import the instance:**

```bash
terraform import aws_instance.practice i-0123456789abcdef0
```

**4. Check that it’s in state:**

```bash
terraform state show aws_instance.practice
```

Use the values shown to complete `aws_instance.practice` with the existing instance’s settings—such as its AMI, instance type, subnet, and security groups.

**5. Preview the result:**

```bash
terraform plan
```

Review the plan carefully. If it proposes replacing the instance, update your configuration to match the real instance before applying anything.

### Key idea

```text
Existing cloud resource + matching Terraform resource block
                         ↓
terraform import RESOURCE_ADDRESS RESOURCE_ID
                         ↓
Terraform state tracks the resource
```

For example, Azure imports use a full Azure resource ID:

```bash
terraform import azurerm_resource_group.practice \
  "/subscriptions/SUBSCRIPTION_ID/resourceGroups/EXISTING_RG"
```

Would you like to practice importing an **AWS EC2 instance** step by step, or use an **Azure resource**?
