data "kubectl_path_documents" "expose_app_ingress_manifests" {
  pattern = "${path.module}/manifests/ingress/*.yaml"
  vars = {
    argocd_domain       = var.argocd_ingress_domain
    argocd_service_name = "argo-cd-argocd-server"
    argocd_namespace    = kubernetes_namespace.argo_namespace.metadata[0].name
  }
}

resource "kubectl_manifest" "deploy_ingress_routing" {
  count     = 2
  yaml_body = element(data.kubectl_path_documents.expose_app_ingress_manifests.documents, count.index)
  wait      = true
}
