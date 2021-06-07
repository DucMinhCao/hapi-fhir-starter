
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
  values    = ["${file("modules/hapi-demo/helm-values/open-emr.yaml")}"]
}

resource "kubernetes_manifest" "create_openemr_ingress" {
  provider = kubernetes-alpha

  depends_on = [
    helm_release.deploy_openemr_stadalon,
  ]

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "Ingress"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/cluster-issuer"           = "letsencrypt-prod"
        "kubernetes.io/ingress.class"              = "nginx"
        "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
        "ingress.kubernetes.io/rewrite-target"     = "/"
      }
      "name"      = "openemr-ingress",
      "namespace" = kubernetes_namespace.create_openemr_namespace.metadata[0].name
    }
    "spec" = {
      "rules" = [
        {
          "host" = "emr.ohmydev.asia"
          "http" = {
            "paths" = [
              {
                "backend" = {
                  "service" = {
                    "name" = "open-emr-charts"
                    "port" = {
                      "number" = 80
                    }
                  }
                }
                "path"     = "/"
                "pathType" = "Prefix"
              },
            ]
          }
        },
      ]
      "tls" = [
        {
          "hosts" = [
            "emr.ohmydev.asia",
          ]
          "secretName" = "emr-ohmydev-asia-tls"
        },
      ]
    }
  }
}
