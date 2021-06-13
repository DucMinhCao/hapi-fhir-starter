data "kubectl_path_documents" "expose_app_ingress_manifests" {
  pattern = "${path.module}/manifests/argocd-ingress.yaml"
  vars = {
    argocd_namespace = kubernetes_namespace.argo_namespace.metadata[0].name
  }
}

resource "kubectl_manifest" "deploy_ingress_routing" {
  count     = 1
  yaml_body = element(data.kubectl_path_documents.expose_app_ingress_manifests.documents, count.index)
  wait      = true
  depends_on = [
    kubectl_manifest.register_cluster_issue_with_letsencrypt
  ]
}
