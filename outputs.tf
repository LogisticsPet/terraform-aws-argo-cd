output "namespace" {
  description = "Namespace of ArgoCD Release"
  value = helm_release.argo_cd.namespace
}
