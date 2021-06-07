
# ----------------------------------------------------------------------------------------------------------------------
# ArgoEvents Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-events" {
  name = "argo-events"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-events"
  version    = var.argo_events_version

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
