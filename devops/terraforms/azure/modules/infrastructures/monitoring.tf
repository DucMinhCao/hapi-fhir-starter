# ----------------------------------------------------------------------------------------------------------------------
# Create namespace to deploy Monitoring Stacks
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "monitoring_namespace" {
  metadata {
    name = "monitoring"
    annotations = {
      "name" = "monitoring"
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Deploy Prometheus
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy_kube_prometheus_stack" {
  name = "kube-prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "16.7.0"
  namespace  = kubernetes_namespace.monitoring_namespace.metadata[0].name

  set {
    name  = "namespace"
    value = kubernetes_namespace.monitoring_namespace.metadata[0].name
  }

  values = [file("${path.module}/manifests/prometheus-values.yaml")]

  depends_on = [
    kubernetes_namespace.monitoring_namespace
  ]

  wait = true
}

# ----------------------------------------------------------------------------------------------------------------------
# Deploy loki-stack
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "deploy_loki_stacks" {
  name = "loki-stack"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.4.1"
  namespace  = kubernetes_namespace.monitoring_namespace.metadata[0].name

  set {
    name  = "namespace"
    value = kubernetes_namespace.monitoring_namespace.metadata[0].name
  }

  values = [file("${path.module}/manifests/loki-values.yaml")]

  depends_on = [
    kubernetes_namespace.monitoring_namespace
  ]

  wait = true
}

