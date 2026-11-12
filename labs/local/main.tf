terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.9.1"
    }
  }
}

resource "local_file" "example" {
  filename = "${path.module}/example.txt"
  content  = "This is an example file created by Terraform.\n"
}

output "created_file" {
  description = "Path to the file managed by Terraform."
  value       = local_file.example.filename
}
