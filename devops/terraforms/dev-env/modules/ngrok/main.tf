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

    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }

    kubernetes-alpha = {
      version = "0.4.0"
    }

  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Deploy ngrok Operator
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "ngrok-namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "deploy-ngrok-operator" {
  name = "ngrok-operator"

  repository = "https://charts.zufardhiyaulhaq.com/"
  chart      = "ngrok-operator"
  version    = var.deploy_version
  namespace  = "ngrok"
  depends_on = [
    var.namespace
  ]
  wait = true
}
