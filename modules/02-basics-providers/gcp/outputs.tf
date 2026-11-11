output "bucket_url" {
  description = "Google Cloud Storage URL."
  value       = google_storage_bucket.lab.url
}

output "bucket_name" {
  description = "Created bucket name."
  value       = google_storage_bucket.lab.name
}
