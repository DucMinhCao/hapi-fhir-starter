terraform {
  required_version = ">= 0.14.8"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.2.0"
    }

    helm = {
      version = "2.1.2"
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Setup Cert Managers
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "cert-manager-namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "deploy-cert-manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.deploy_version
  namespace  = var.namespace
  depends_on = [
    kubernetes_namespace.cert-manager-namespace
  ]
  wait = true
}
