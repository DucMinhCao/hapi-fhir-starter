# Create nginx namespace
resource "kubernetes_namespace" "nginx_ingress_namespace" {
  metadata {
    annotations = {
      name = "nginx"
    }
    name = "nginx"
  }
}

# Deploy Ingress Controller Traefik
resource "helm_release" "deploy_nginx_ingress_controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.nginx_ingress_namespace.metadata[0].name
  version    = "3.33.0"
  wait       = true

  values = [file("${path.module}/manifests/nginx-values.yaml")]
}

resource "kubernetes_ingress" "mock_ingress_to_get_ip" {
  metadata {
    name      = "mock-ingress-to-get-ip"
    namespace = kubernetes_namespace.nginx_ingress_namespace.metadata[0].name
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "127.0.0.1.nio.io"
      http {

        path {
          backend {
            service_name = "ingress-nginx-controller"
            service_port = 80
          }
          path = "/"
        }
      }
    }
  }
  wait_for_load_balancer = true
  depends_on = [
    helm_release.deploy_nginx_ingress_controller
  ]
}

output "ingress_ip" {
  value = kubernetes_ingress.mock_ingress_to_get_ip.status[0].load_balancer[0].ingress[0].ip
}
