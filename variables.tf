variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "certificate_issuer" {
  type        = string
  description = "Cert manager issuer name for Ingress certificate"
}

variable "domain" {
  type        = string
  description = "Application domain name"
}

variable "namespace" {
  type = string
  description = "Namespace to deploy"
}
