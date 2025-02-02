terraform {
  required_version = "1.10.3"
  required_providers {
    aws = {
      version = "5.82.2"
      source  = "hashicorp/aws"
    }
    kubernetes = {
      version = "2.35.1"
      source  = "hashicorp/kubernetes"
    }
    helm = {
      version = "2.17.0"
      source  = "hashicorp/helm"
    }
    tls = {
      version = "4.0.6"
      source  = "hashicorp/tls"
    }
  }
}
