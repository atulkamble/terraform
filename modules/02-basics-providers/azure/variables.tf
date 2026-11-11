variable "resource_group_name" {
  description = "Name of the disposable training resource group."
  type        = string
  default     = "rg-terraform-training-lab"
}

variable "location" {
  description = "Azure region for the resource group."
  type        = string
  default     = "centralindia"
}
