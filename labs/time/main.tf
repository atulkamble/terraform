terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.14.2"
    }
  }
}

provider "time" {}

resource "time_static" "creation_time" {}

output "creation_time" {
  value = time_static.creation_time.rfc3339
}