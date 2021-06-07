terraform {
  required_version = ">=0.14.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.2.0"
    }
    helm = {
      version = "2.1.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    k3d = {
      source  = "3rein/k3d"
      version = "0.0.4"
    }
  }
}

provider "kubernetes" {
  config_path = var.kube_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
}

resource "null_resource" "check_cluster_ready" {
  depends_on = [
    k3d_cluster.mycluster
  ]
  provisioner "local-exec" {
    command = "echo ${k3d_cluster.mycluster.name}"
  }
  provisioner "local-exec" {
    command = "kubectl wait --for=condition=Available deploy/traefik -n kube-system --timeout=200s"
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# deploy Traefik Dashboard
# ----------------------------------------------------------------------------------------------------------------------
resource "null_resource" "deploy_traefik_dashboards" {

  provisioner "local-exec" {
    command = "kubectl apply -f ${abspath(path.root)}/manifests/traefik-dashboard.yaml"
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# deploy ArgoCD
# ----------------------------------------------------------------------------------------------------------------------

module "deploy_argo" {
  source = "../modules/argo"
}


resource "kubernetes_ingress" "deploy_ingress_argocd" {
  depends_on = [
    kubernetes_namespace.argo-namespace
  ]
  metadata {
    name      = "argocd-server-ingress"
    namespace = var.argo_namespace
  }
  spec {
    rule {
      host = "argocd-server.127.0.0.1.nip.io"
      http {
        path {
          path = "/*"
          backend {
            service_name = "argo-cd-argocd-server"
            service_port = 80
          }
        }
      }
    }
  }

}

/* 
resource "kubernetes_namespace" "create_namepsace_for_argo" {
  metadata {
    name = "argocd"
  }
}
resource "null_resource" "deploy_argocd" {
  depends_on = [
    kubernetes_namespace.create_namepsace_for_argo
  ]
  provisioner "local-exec" {
    command = "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl wait -n argocd deploy/argocd-server --for condition=available --timeout=300s"
  }

  // Print ArgoCD Admin
  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
  }

  // Expose ingress of argocd server
  provisioner "local-exec" {
    command = "kubectl apply -f ${abspath(path.root)}/manifests/argocd-server-ingress.yaml"
  }
}

resource "kubernetes_ingress" "deploy_ingress_argocd" {
  metadata {
    name = "argocd-server-ingress"
    namespace = kubernetes_namespace.create_namepsace_for_argo
  }
  spec {
    rule {
      host = "argocd-server.127.0.0.1.nip.io"
      http {
        path {
          path = "/*"
          backend {
            service_name = "argocd-server"
            service_port = 80
          }
        }
      }
    }

} */


/* module "create-argo-cd" {
  source = "../modules/argo"
  depends_on = [
    null_resource.create-ingress-for-traefik-dashboard
  ]
} */

/* module "install_cert_mananger" {
  source = "../modules/cert-manager"
} */

/* module "install_github_actions" {
  source       = "../modules/github-actions"
  github_token = var.github_token
  depends_on = [
    module.install_cert_mananger.id
  ]
} */
