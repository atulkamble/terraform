variable "project_id" {
  description = "Google Cloud sandbox project ID."
  type        = string
}

variable "region" {
  description = "Region for the training bucket."
  type        = string
  default     = "asia-south1"
}

variable "bucket_name" {
  description = "Globally unique bucket name."
  type        = string
}
