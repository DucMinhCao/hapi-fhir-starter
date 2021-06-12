variable "cert_manager_name" {
  type    = string
  default = "letsencrypt-prod"
}

# Create cert manager namespace
resource "kubernetes_namespace" "cert_manager_namespace" {
  metadata {
    annotations = {
      name = "cert-manager"
    }
    name = "cert-manager"
  }
}

# Install helm release Cert Manager
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = "1.3.1"
  namespace  = kubernetes_namespace.cert_manager_namespace.metadata[0].name
  set {
    name  = "installCRDs"
    value = "true"
  }
  wait = true
}

# Create certificates issuers based on Letsencrypts
data "kubectl_path_documents" "cluster_issuer_manifests" {
  pattern = "${path.module}/manifests/certs-managers/*.yaml"
}

resource "kubectl_manifest" "register_cluster_issue_with_letsencrypt" {
  count     = length(data.kubectl_path_documents.cluster_issuer_manifests.documents)
  yaml_body = element(data.kubectl_path_documents.cluster_issuer_manifests.documents, count.index)
  depends_on = [
    helm_release.cert_manager
  ]
}
