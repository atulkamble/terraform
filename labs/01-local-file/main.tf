terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "local_file" "lab" {
  filename = "${path.module}/terraform-lab.txt"
  content  = "Hello from Terraform!\nThis file is managed as code.\n"
}
