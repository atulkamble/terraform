terraform {
  required_version = ">= 1.5.0, < 2.0.0"
}

resource "local_file" "summary" {
  filename = "${path.module}/terraform-lab-summary.txt"
  content  = "Environment: ${var.environment}\nOwner: ${var.owner}\n"
}
