terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

  backend "gcs" {
    bucket  = "83bb9cbede83ff98-bucket-tfstate"
    prefix  = "terraform/state"
  }
}
