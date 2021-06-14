# Create open-emr namespace
resource "kubernetes_namespace" "demo_fhir_namespace" {
  metadata {
    annotations = {
      name = "demo-fhir-namespace"
    }
    name = "demo-fhir-namespace"
  }
}

# # Deploy HAPI FHIR JPA Server Demo
# resource "helm_release" "deploy_hapi_fhir_jpa_server" {
#   name       = "hapi-fhir-jpaserver"
#   repository = "https://chgl.github.io/charts"
#   chart      = "hapi-fhir-jpaserver"
#   namespace  = kubernetes_namespace.demo_fhir_namespace.metadata[0].name
#   version    = "0.4.1"
#   values     = ["${file("${path.module}/helm-values/hapi-jpa-server.yaml")}"]
#   wait       = false
# }

# # Deploy Azure FHIR Server
# resource "helm_release" "deploy_azure_fhir_server" {
#   name       = "fhir-server"
#   repository = "https://chgl.github.io/charts"
#   chart      = "fhir-server"
#   namespace  = kubernetes_namespace.demo_fhir_namespace.metadata[0].name
#   version    = "0.5.1"
#   wait       = false
# }
