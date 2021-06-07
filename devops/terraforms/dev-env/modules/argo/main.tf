terraform {
  required_version = ">= 0.13.3"

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
# Create namespace to deploy Argo
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "argo-namespace" {
  metadata {
    name = var.argo_namespace
  }
}
