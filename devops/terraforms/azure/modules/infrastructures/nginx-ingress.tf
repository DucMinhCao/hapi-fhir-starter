variable "base_domain" {
  type    = string
  default = "labs.ohmydev.asia"
}

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
  version    = "3.32.0"
  wait       = true
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command     = "kubectl get ingress --all-namespaces -o=jsonpath=\"{.items[0].status.loadBalancer.ingress[0].ip}\" <(echo $KUBECONFIG | base64 --decode)"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = var.kube_config
    }
  }
}
