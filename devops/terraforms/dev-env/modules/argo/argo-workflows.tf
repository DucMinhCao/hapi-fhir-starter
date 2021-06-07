
# ----------------------------------------------------------------------------------------------------------------------
# ArgoEvents Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-workflows" {
  name = "argo-workflows"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-workflows"
  version    = var.argo_workflow_version

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
}
