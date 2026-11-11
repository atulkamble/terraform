output "created_file" {
  description = "Path to the file managed by Terraform."
  value       = local_file.lab.filename
}
