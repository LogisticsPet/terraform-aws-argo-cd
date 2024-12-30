resource "tls_private_key" "repo_server_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "repo_server_request" {
  private_key_pem = tls_private_key.repo_server_key.private_key_pem
  subject {
    organization = "Logistics Online test company"
  }
  dns_names = [
    "localhost",
    "argocd-server",
    "argocd-server.${kubernetes_namespace.argocd.metadata[0].name}",
    "argocd-server.${kubernetes_namespace.argocd.metadata[0].name}.svc",
    "argocd-server.${kubernetes_namespace.argocd.metadata[0].name}.svc.cluster.local"
  ]
  ip_addresses = [
    "127.0.0.1"
  ]
}

resource "kubernetes_certificate_signing_request_v1" "repo_server_cert_req" {
  metadata {
    name = "argocd-repo-server-cert-request"
  }
  spec {
    usages      = ["digital signature", "key encipherment", "server auth"]
    signer_name = "beta.eks.amazonaws.com/app-serving"
    request     = tls_cert_request.repo_server_request.cert_request_pem
  }

  auto_approve = true
}

resource "kubernetes_secret" "argo_repo_server_cert" {
  metadata {
    name      = "argocd-repo-server-tls"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
  data = {
    "ca.crt"  = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    "tls.crt" = kubernetes_certificate_signing_request_v1.repo_server_cert_req.certificate
    "tls.key" = tls_private_key.repo_server_key.private_key_pem
  }
  type = "kubernetes.io/tls"
}
