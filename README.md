![ci](https://github.com/LogisticsPet/terraform-aws-argo-cd/actions/workflows/ci.yml/badge.svg?branch=main)
![lint](https://github.com/LogisticsPet/terraform-aws-argo-cd/actions/workflows/lint.yml/badge.svg?branch=main)
![sec](https://github.com/LogisticsPet/terraform-aws-argo-cd/actions/workflows/tfsec.yml/badge.svg?branch=main)

## Introduction
Terraform module to provision Argo CD on EKS Cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.10.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.82.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.17.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.35.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.35.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/2.17.0/docs/resources/release) | resource |
| [kubernetes_certificate_signing_request_v1.dex_server_cert_request](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/certificate_signing_request_v1) | resource |
| [kubernetes_certificate_signing_request_v1.repo_server_cert_req](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/certificate_signing_request_v1) | resource |
| [kubernetes_certificate_signing_request_v1.server_cert_request](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/certificate_signing_request_v1) | resource |
| [kubernetes_namespace.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/namespace) | resource |
| [kubernetes_secret.argo_repo_server_cert](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/secret) | resource |
| [kubernetes_secret.argo_server_cert](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/secret) | resource |
| [kubernetes_secret.argocd-dex-server-tls](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/secret) | resource |
| [tls_cert_request.dex_server_cert_request](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/resources/cert_request) | resource |
| [tls_cert_request.repo_server_request](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/resources/cert_request) | resource |
| [tls_cert_request.server_cert_request](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/resources/cert_request) | resource |
| [tls_private_key.dex_server_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/resources/private_key) | resource |
| [tls_private_key.repo_server_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/resources/private_key) | resource |
| [tls_private_key.server_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/resources/private_key) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/5.82.2/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/5.82.2/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_issuer"></a> [certificate\_issuer](#input\_certificate\_issuer) | Cert manager issuer name for Ingress certificate | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Application domain name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
