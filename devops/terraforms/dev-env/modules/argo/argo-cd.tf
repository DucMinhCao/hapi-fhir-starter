# ----------------------------------------------------------------------------------------------------------------------
# ArgoCD Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-cd" {
  name = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-cd"
  version    = var.argo_cd_version

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "installCRDs"
    value = false
  }

  set {
    name  = "namespace"
    value = var.argo_namespace
  }

  depends_on = [
    kubernetes_namespace.argo-namespace
  ]

  wait = true

  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
  }
}

