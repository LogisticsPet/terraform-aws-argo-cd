resource "tls_private_key" "dex_server_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "dex_server_cert_request" {
  private_key_pem = tls_private_key.dex_server_key.private_key_pem
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

resource "kubernetes_certificate_signing_request_v1" "dex_server_cert_request" {
  metadata {
    name = "argocd-dex-server-cert-request"
  }
  spec {
    usages      = ["digital signature", "key encipherment", "server auth"]
    signer_name = "beta.eks.amazonaws.com/app-serving"
    request     = tls_cert_request.dex_server_cert_request.cert_request_pem
  }

  auto_approve = true
}

resource "kubernetes_secret" "argocd-dex-server-tls" {
  metadata {
    name      = "argocd-dex-server-tls"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
  data = {
    "ca.crt"  = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    "tls.crt" = kubernetes_certificate_signing_request_v1.dex_server_cert_request.certificate
    "tls.key" = tls_private_key.dex_server_key.private_key_pem
  }
  type = "kubernetes.io/tls"
}
