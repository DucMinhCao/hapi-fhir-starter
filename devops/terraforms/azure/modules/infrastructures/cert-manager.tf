variable "cert_manager_name" {
  type = string
  default = "letsencrypt-prod"
}
# Create cert manager namespace
resource "kubernetes_namespace" "cert_manager_namespace" {
  metadata {
    annotations = {
      name = "cert-manager"
    }
    name = "cert-manager"
  }
}

# Install helm release Cert Manager
resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = "1.3.1"
  namespace  = kubernetes_namespace.cert_manager_namespace.metadata[0].name
  set {
    name  = "installCRDs"
    value = "true"
  }
  wait = true
}

resource "kubernetes_manifest" "register_cluster_issue_with_letsencrypt" {
  provider = kubernetes-alpha

  depends_on = [
    kubernetes_namespace.cert_manager_namespace,
    helm_release.cert-manager
  ]

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = var.cert_manager_name
    }
    "spec" = {
      "acme" = {
        "email" = "khoahoang@kms-technology.com"
        "privateKeySecretRef" = {
          "name" = var.cert_manager_name
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "nginx"
              }
            }
          },
        ]
      }
    }
  }
}

output "cert_manager_name" {
  value = var.cert_manager_name
}