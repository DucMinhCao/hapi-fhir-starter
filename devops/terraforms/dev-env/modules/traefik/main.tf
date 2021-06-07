terraform {

  required_version = ">=0.14.0"
  required_providers {
    helm = {
      version = "2.1.2"
    }

     kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.1"
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# ArgoCD Resources
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy-traefik-controller" {
  name = "traefik"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = "9.19.1"

  set {
    name  = "experimental.plugins.enabled"
    value = true
  }

  set {
    name  = "pilot.enabled"
    value = true
  }

  set {
    name  = "pilot.dashboard"
    value = true
  }

  wait = true
}


resource "kubectl_manifest" "deploy-dashboard-for-traefik" {
  depends_on = [
    helm_release.deploy-traefik-controller
  ]
  
  yaml_body = <<YAML
# runner.yaml
apiVersion: actions.summerwind.dev/v1alpha1
kind: Runner
metadata:
  name: example-runner
spec:
  repository: summerwind/actions-runner-controller
  env: []

YAML
}
