locals {
  ingress_host = "argo.${var.domain}"
}

resource "helm_release" "argo_cd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  name       = "argo-cd"
  version    = "6.11.1"
  namespace  = var.namespace
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
          enabled = true
          hosts = [
            local.ingress_host
          ]
          paths = [
            "/"
          ]
          tls = [
            {
              secretName = "argo-ingress-cert"
              hosts = [
                local.ingress_host
              ]
            }
          ]
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
