# Module 2 — Terraform Fundamentals and Providers

This guide supports the Terraform training session. It introduces Infrastructure as Code (IaC), HCL, providers, resources, the Terraform CLI workflow, variables, outputs, and state.

> **Cloud cost reminder:** the local-file lab does not create cloud resources. Provider examples may create billable resources. Use a dedicated lab account, review every plan, and destroy lab resources when finished. Never commit credentials, state files, private keys, or real variable files.

## Session outcomes

By the end of the session, learners should be able to:

- Explain IaC, its benefits, and its tradeoffs.
- Describe Terraform's configuration, provider, resource, state, and execution workflow.
- Read basic HCL and distinguish resource types from Terraform local names.
- Run init, fmt, validate, plan, apply, output, and destroy commands.
- Configure cloud authentication without embedding credentials in code.
- Explain variables, outputs, state, and why state must be protected.

## 1. Infrastructure as Code

Infrastructure as Code describes infrastructure in machine-readable files that can be reviewed and applied repeatedly. Teams record desired configuration, inspect proposed changes, and apply them with automation instead of creating every resource manually.

| Benefit | Meaning |
|---|---|
| Repeatability | Reuse configuration to create similar environments. |
| Reviewability | Inspect code changes and plans before changing infrastructure. |
| Consistency | Reduce differences caused by manual setup. |
| Automation | Integrate provisioning into scripts and delivery pipelines. |
| Recoverability | Recreate infrastructure from maintained configuration, subject to data and state requirements. |

IaC also requires care: a mistaken change can affect many resources, provider behavior can change, and state can contain sensitive values. Plans, permissions, backups, and cleanup are part of the workflow.

### Common IaC options

| Platform | Native or commonly used option | Purpose |
|---|---|---|
| AWS | CloudFormation | Provision AWS resources |
| Microsoft Azure | ARM templates / Bicep | Provision Azure resources |
| Google Cloud | Infrastructure Manager / Terraform | Provision Google Cloud resources |
| Multi-cloud | Terraform | Provision resources through provider plugins |

Terraform is maintained by HashiCorp. Terraform configuration is commonly written in HashiCorp Configuration Language (HCL), in files ending in .tf. Providers let Terraform communicate with cloud platforms and other APIs.

## 2. Terraform architecture

- **Configuration**: .tf files describing desired resources.
- **Terraform CLI**: reads configuration and performs commands such as plan and apply.
- **Provider**: a plugin that lets Terraform manage a platform, such as AWS, Azure, or Google Cloud.
- **Resource**: an object Terraform creates or manages, such as an EC2 instance or storage bucket.
- **State**: Terraform's record of objects it manages and their attributes.
- **Backend**: where Terraform stores state; the default backend stores it locally.

Terraform loads all .tf files in the current working directory as one configuration. Teams often split files by purpose (provider.tf, variables.tf, main.tf, outputs.tf) for readability. The filenames do not establish execution order.

## 3. Install Terraform

Use the official installation instructions for your operating system and current release: [developer.hashicorp.com/terraform/install](https://developer.hashicorp.com/terraform/install).

### Amazon Linux 2023

~~~bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo dnf install -y terraform
terraform version
~~~

### macOS with Homebrew

~~~bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
~~~

For Ubuntu, Debian, and Windows, follow the official installation guide above. Open a new terminal if needed and confirm that terraform version works.

## 4. First hands-on lab: create a local file

This lab does not need a cloud account and does not create cloud resources.

~~~bash
git clone https://github.com/atulkamble/terraform.git
cd terraform/labs/local
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
cat example.txt
terraform destroy
~~~

At the apply prompt, inspect the plan and type yes to proceed. PowerShell instructions are in the lab README. The repository lab is labs/local; see its README for the matching commands.

### What each command does

| Command | Purpose |
|---|---|
| terraform init | Initializes the working directory, backend, and provider/module dependencies. |
| terraform fmt | Formats HCL files consistently. |
| terraform validate | Checks configuration syntax and internal consistency. |
| terraform plan | Shows proposed actions without applying them. |
| terraform apply | Applies reviewed changes after confirmation. |
| terraform output | Prints outputs declared by the configuration. |
| terraform destroy | Proposes and removes resources managed by this configuration. |

Run Terraform commands from the directory containing the configuration you intend to use.

## 5. HCL blocks, providers, and resources

A minimal AWS EC2 configuration has provider requirements, provider settings, and a resource. This illustrates HCL structure; it is not a complete production deployment.

~~~hcl
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

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
~~~

- aws_instance is the **resource type**. It tells Terraform what provider resource to manage.
- web is the **Terraform local name**. It identifies the resource inside the configuration; it is not automatically the EC2 Name tag.
- var.ami_id and other var expressions refer to input variables.
- The Name tag is what AWS displays as the instance name. Tags are optional for EC2 creation, but useful for identification and cost tracking.
- Provider requirements declare provider source and version constraints. Provider settings configure items such as region. Keep credentials outside the configuration.
- HCL argument order is generally flexible. Terraform evaluates dependencies from references, rather than requiring resources to appear in a particular textual order.

See the [AWS example](aws/README.md), [Azure example](azure/README.md), and [GCP example](gcp/README.md) for authentication, resources, costs, and cleanup.

## 6. Authenticate to a cloud provider

For a local AWS lab, configure the AWS CLI using a named profile or another approved method:

~~~bash
aws configure --profile terraform-lab
aws sts get-caller-identity --profile terraform-lab
export AWS_PROFILE=terraform-lab
~~~

On PowerShell:

~~~powershell
$env:AWS_PROFILE = "terraform-lab"
aws sts get-caller-identity
~~~

Use temporary credentials or an assigned role where possible. Grant only permissions required by the lab. Avoid long-lived IAM user access keys for routine or team use; never paste credentials into Terraform files or Git.

For Azure, sign in using the Azure CLI (az login). For Google Cloud, use Application Default Credentials (gcloud auth application-default login) for a local learning environment. Follow your organization's identity policies.

## 7. Variables and outputs

Variables make configuration reusable without editing resource code for every run. Outputs display selected values after Terraform applies the configuration.

~~~hcl
variable "instance_type" {
  description = "EC2 instance type for the lab"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "A valid AMI ID for the selected AWS region"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 lab instance"
  type        = string
  default     = "terraform-lab"
}
~~~

~~~hcl
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}
~~~

Set required values interactively or use a local terraform.tfvars file excluded from Git:

~~~hcl
ami_id        = "ami-replace-with-a-current-region-specific-id"
instance_type = "t3.micro"
instance_name = "terraform-session"
~~~

AMI IDs are region-specific and can become outdated. Choose a current AMI for your region and operating system; do not copy a sample ID blindly. Avoid putting secrets in ordinary variables or outputs. Marking an output sensitive only redacts normal display; it does not remove the value from state.

## 8. Understanding Terraform state

Terraform state links addresses in configuration to real infrastructure objects. It records identifiers, attributes, dependencies, and metadata so Terraform can calculate differences between desired configuration and managed infrastructure.

~~~bash
terraform state list
terraform state show aws_instance.web
terraform output
~~~

Treat state as sensitive. It can contain credentials or other secret values even when they are not shown in terminal output. Do not commit terraform.tfstate, terraform.tfstate.backup, plan files, or credentials to Git.

### Local and remote state

- **Local state** is stored in the working directory. It is convenient for an individual disposable exercise, but it is easy to lose and does not provide team coordination.
- **Remote state** is stored in a shared backend with controlled access. Configure encryption, versioning, backups, and locking according to backend capabilities and team policies.
- **State locking** prevents concurrent operations from modifying the same state at the same time when supported by the chosen backend. It is not a substitute for access control or backups.
- terraform.tfstate.backup may be written by local operations, but it is not a reliable backup strategy. Use a supported, access-controlled backend and backup/versioning plan for shared environments.

See [Module 3 — Variables, State, and Best Practices](../03-variables-state-best-practices/README.md) and the [AWS S3 backend example](../03-variables-state-best-practices/aws-s3-backend/README.md). Backend resources such as an S3 bucket must be created and secured before configuring that backend. Use unique names and follow current backend documentation.

## 9. Resource count and addresses

Terraform can create repeated resources with count, but the configuration needs a valid region-specific AMI and suitable key/network setup.

~~~hcl
resource "aws_instance" "web" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "web-${count.index + 1}"
  }
}
~~~

With count, instances are addressed by index, such as aws_instance.web[0] and aws_instance.web[1]. For uniquely named objects, for_each may provide clearer stable keys. Avoid mixing a count-based example with another resource block using the same local name.

## 10. Renaming and targeted operations

Changing the AWS Name tag changes the displayed tag. Changing a Terraform resource's local name (for example, web to app) changes its Terraform address. Terraform may interpret that as removing one address and creating another unless you add a moved block or use the appropriate state-move workflow.

Targeted commands such as terraform apply -target=... and terraform destroy -target=... are for exceptional recovery or carefully scoped operations. They can leave other changes unapplied. For normal changes, update configuration, review the full plan, and apply it.

## 11. Suggested classroom sequence

1. Explain desired state, repeatability, drift, and IaC tradeoffs.
2. Show the Terraform architecture diagram and identify CLI, configuration, provider, resource, and state.
3. Install Terraform and verify the CLI.
4. Complete the local-file lab together.
5. Read the AWS EC2 example and explain each HCL block before running a cloud plan.
6. Demonstrate variables and outputs; inspect state without exposing secrets.
7. Discuss remote state, locking, team workflows, and version control.
8. Have learners explain the plan before applying.
9. Destroy lab resources and confirm cleanup.

## Quick knowledge check

1. What is the difference between a provider and a resource?
2. What does the local name in a resource declaration identify?
3. Which command previews changes without applying them?
4. Why must state files be protected and excluded from Git?
5. Why should an AMI ID be checked for the selected region?
6. When is a remote backend preferable to local state?
7. What should you do after finishing a cloud lab?

## Related material

- [Module 1 — Introduction to Terraform](../01-introduction/README.md)
- [AWS provider lab](aws/README.md)
- [Azure provider lab](azure/README.md)
- [Google Cloud provider lab](gcp/README.md)
- [Module 3 — Variables, State, and Best Practices](../03-variables-state-best-practices/README.md)
- [Local-file lab](../../labs/local/README.md)
