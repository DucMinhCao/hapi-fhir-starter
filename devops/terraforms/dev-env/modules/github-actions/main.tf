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
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.1"
    }

  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Setup Github Action Runners
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "github-actions-namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "github-actions-access-token" {
  metadata {
    name      = "controller-manager"
    namespace = var.namespace
  }
  data = {
    github_token = var.github_token
  }
  depends_on = [
    kubernetes_namespace.github-actions-namespace
  ]
}

resource "helm_release" "deploy-github-actions-runner" {
  name = "actions-runner-controller"

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  version    = var.deploy_version
  namespace  = var.namespace
  depends_on = [
    kubernetes_namespace.github-actions-namespace
  ]
  wait = true
}
