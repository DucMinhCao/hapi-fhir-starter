variable "argocd_ingress_domain" {
  type    = string
  default = "argocd.labs.ohmydev.asia"
}

# ----------------------------------------------------------------------------------------------------------------------
# Create namespace to deploy Argo
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "argo-namespace" {
  metadata {
    name = "argocd"
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# ArgoCD Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-argo-cd" {
  name = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm/"
  chart      = "argo-cd"
  version    = "3.6.1"
  namespace  = kubernetes_namespace.argo-namespace.metadata[0].name
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
    value = kubernetes_namespace.argo-namespace.metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.argo-namespace
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
  version    = "1.4.2"
  namespace  = kubernetes_namespace.argo-namespace.metadata[0].name
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
    value = kubernetes_namespace.argo-namespace.metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.argo-namespace
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
  version    = "0.1.3"
  namespace  = kubernetes_namespace.argo-namespace.metadata[0].name

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
    value = kubernetes_namespace.argo-namespace.metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.argo-namespace
  ]

  wait = true
}


resource "kubernetes_manifest" "create_argocd_ingress_with_tls" {
  provider = kubernetes-alpha

  depends_on = [
    helm_release.cert-manager,
    kubernetes_manifest.register_cluster_issue_with_letsencrypt
  ]

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "Ingress"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/cluster-issuer"               = var.cert_manager_name
        "kubernetes.io/ingress.class"                  = "nginx"
        "nginx.ingress.kubernetes.io/ssl-redirect"     = "false"
        "ingress.kubernetes.io/rewrite-target"         = "/"
        "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
      }
      "name"      = "argo-cd-argocd-server-ingress",
      "namespace" = kubernetes_namespace.argo-namespace.metadata[0].name
    }
    "spec" = {
      "rules" = [
        {
          "host" = var.argocd_ingress_domain
          "http" = {
            "paths" = [
              {
                "backend" = {
                  "service" = {
                    "name" = "argo-cd-argocd-server"
                    "port" = {
                      "number" = 443
                    }
                  }
                }
                "path"     = "/"
                "pathType" = "Prefix"
              },
            ]
          }
        },
      ]
      "tls" = [
        {
          "hosts" = [
            var.argocd_ingress_domain,
          ]
          "secretName" = "argocd-ingress-tls"
        },
      ]
    }
  }
}
