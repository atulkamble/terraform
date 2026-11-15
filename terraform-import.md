Use **US East (N. Virginia)** (`us-east-1`) and `t3.micro`. Replace the example instance ID with the ID of the EC2 instance you want to import.

### `main.tf`

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
  region = "us-east-1"
}

resource "aws_instance" "practice" {
  ami           = "ami-096ef200a877f36af"
  instance_type = "t3.micro"
}
```

### Run the import

```bash
terraform init
terraform import aws_instance.practice i-REPLACE_WITH_YOUR_INSTANCE_ID
terraform state show aws_instance.practice
terraform plan
```

The AMI and instance type must match the existing instance. Review `terraform plan` and complete `main.tf` with any additional settings it reports before applying changes. Import adds the existing instance to Terraform state; it does not create the instance.
