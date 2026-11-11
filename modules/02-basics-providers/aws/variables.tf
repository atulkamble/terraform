variable "aws_region" {
  description = "AWS region for the lab bucket."
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name; replace the example with your own unique value."
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "S3 bucket names must be between 3 and 63 characters."
  }
}
