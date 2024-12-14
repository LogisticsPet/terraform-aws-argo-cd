terraform {
  required_version = "1.10.2"
  required_providers {
    aws = {
      version = "5.81.0"
      source  = "hashicorp/aws"
    }
    kubernetes = {
      version = "2.35.0"
      source  = "hashicorp/kubernetes"
    }
    helm = {
      version = "2.16.1"
      source  = "hashicorp/helm"
    }
    tls = {
      version = "4.0.6"
      source  = "hashicorp/tls"
    }
  }
}
