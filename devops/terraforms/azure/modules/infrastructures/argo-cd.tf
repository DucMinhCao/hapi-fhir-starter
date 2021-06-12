variable "argocd_ingress_domain" {
  type    = string
  default = "argocd.ohmydev.asia"
}

# ----------------------------------------------------------------------------------------------------------------------
# Create namespace to deploy Argo
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "argo_namespace" {
  metadata {
    name = "argo-cd"
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# ArgoCD Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-cd" {
  name = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-cd"
  version    = "3.6.8"
  namespace  = kubernetes_namespace.argo_namespace.metadata[0].name
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
    value = kubernetes_namespace.argo_namespace.metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.argo_namespace
  ]

  wait = true
}


# ----------------------------------------------------------------------------------------------------------------------
# ArgoEvents Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-events" {
  name = "argo-events"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-events"
  version    = "1.6.2"
  namespace  = kubernetes_namespace.argo_namespace.metadata[0].name
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
    value = kubernetes_namespace.argo_namespace.metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.argo_namespace
  ]

  wait = true
}

# ----------------------------------------------------------------------------------------------------------------------
# ArgoWorkflow Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-workflows" {
  name = "argo-workflows"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-workflows"
  version    = "0.2.5"
  namespace  = kubernetes_namespace.argo_namespace.metadata[0].name

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
    value = kubernetes_namespace.argo_namespace.metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.argo_namespace
  ]

  wait = true
}
