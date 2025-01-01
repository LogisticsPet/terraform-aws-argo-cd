locals {
  ingress_host = "argo.${var.domain}."
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argo_cd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  name       = "argo-cd"
  version    = "7.7.11"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  atomic     = true
  values = [
    yamlencode({
      fullNameOverride = "argo-cd"
      crds = {
        keep = false
      }
      redis-ha = {
        enabled = true
      }
      controller = {
        replicas = 1
      }
      repoServer = {
        autoscaling = {
          enabled     = true
          minReplicas = 2
        }
      }
      applicationSet = {
        autoscaling = {
          enabled     = true
          minReplicas = 2
        }
      }
      server = {
        autoscaling = {
          enabled : true
          minReplicas : 2
        }
        ingress = {
          enabled  = true
          hostname = local.ingress_host
          paths = [
            "/"
          ]
          tls = true
          annotations = {
            "kubernetes.io/ingress.class"                                       = "nginx"
            "kubernetes.io/ingress.allow-http"                                  = "false"
            "nginx.ingress.kubernetes.io/backend-protocol"                      = "HTTPS"
            "nginx.ingress.kubernetes.io/force-ssl-redirect"                    = "true"
            "nginx.ingress.kubernetes.io/auth-tls-verify-client"                = "off"
            "nginx.ingress.kubernetes.io/auth-tls-pass-certificate-to-upstream" = "false"
            "cert-manager.io/cluster-issuer"                                    = var.certificate_issuer
            "external-dns.alpha.kubernetes.io/hostname"                         = local.ingress_host
          }
        }
      }
    })
  ]
}
