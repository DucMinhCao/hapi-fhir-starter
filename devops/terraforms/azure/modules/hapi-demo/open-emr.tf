# Create open-emr namespace
resource "kubernetes_namespace" "create_openemr_namespace" {
  metadata {
    annotations = {
      name = "openemrs"
    }
    name = "openemrs"
  }
}

# Deploy Ingress Controller Traefik
resource "helm_release" "deploy_openemr_stadalon" {
  name      = "open-emr-charts"
  chart     = "../../charts/open-emr-charts"
  namespace = kubernetes_namespace.create_openemr_namespace.metadata[0].name
  version   = "0.1.0"
  wait      = false
  values    = ["${file("${path.module}/helm-values/open-emr.yaml")}"]
}