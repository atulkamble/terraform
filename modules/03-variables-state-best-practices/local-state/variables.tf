variable "environment" {
  description = "Environment label written to the local file."
  type        = string
  default     = "training"

  validation {
    condition     = contains(["training", "development"], var.environment)
    error_message = "Use training or development for this exercise."
  }
}

variable "owner" {
  description = "Learner name or team alias."
  type        = string
  default     = "terraform-student"
}
