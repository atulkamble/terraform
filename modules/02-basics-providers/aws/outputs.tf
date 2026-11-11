output "bucket_name" {
  description = "Name of the training bucket."
  value       = aws_s3_bucket.lab.id
}

output "bucket_arn" {
  description = "ARN of the training bucket."
  value       = aws_s3_bucket.lab.arn
}
