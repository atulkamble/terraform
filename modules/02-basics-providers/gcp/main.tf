terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "lab" {
  name                        = var.bucket_name
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = false

  labels = {
    environment = "terraform-training"
    managed_by  = "terraform"
  }
}
