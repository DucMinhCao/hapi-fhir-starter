# Create nginx namespace
resource "kubernetes_namespace" "nginx_ingress_namespace" {
  metadata {
    annotations = {
      name = "ingress"
    }
    name = "ingress"
  }
}

# Deploy Ingress Controller Traefik
resource "helm_release" "deploy_nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  namespace  = kubernetes_namespace.nginx_ingress_namespace.metadata[0].name
  version    = "0.9.3"
  wait       = true

  set {
    name  = "prometheus.create"
    value = true
  }
  set {
    name  = "prometheus.port"
    value = 9901
  }
  set {
    name  = "controller.enableLatencyMetrics"
    value = true
  }

  set {
    name  = "controller.setAsDefaultIngress"
    value = true
  }
}
resource "kubernetes_service" "create_prometheus_metrics_endpoint" {
  metadata {
    name      = "nginx-ingress-prometheus"
    namespace = kubernetes_namespace.nginx_ingress_namespace.metadata[0].name
  }
  spec {
    selector = {
      app = "nginx-ingress-nginx-ingress"
    }
    port {
      name        = "nginx-ingress-prometheus"
      port        = 80
      target_port = 9901
    }
    type = "ClusterIP"
  }
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
            service_name = "nginx-ingress-nginx-ingress"
            service_port = 80
          }
          path = "/"
        }
      }
    }
  }
  wait_for_load_balancer = true
  depends_on = [
    helm_release.deploy_nginx_ingress
  ]
}

output "ingress_ip" {
  value = kubernetes_ingress.mock_ingress_to_get_ip.status[0].load_balancer[0].ingress[0].ip
}
