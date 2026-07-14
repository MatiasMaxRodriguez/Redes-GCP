terraform {
  required_version = "~> 1.8"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }   
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}