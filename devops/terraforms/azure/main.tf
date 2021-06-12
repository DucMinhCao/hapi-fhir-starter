terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.62.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "HealthcareLabs"
    storage_account_name = "healthcareterraform"
    container_name       = "terraform-state"
    key                  = "healthcaredev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}

module "aks_cluster" {
  source             = "./modules/cluster"
  azure_project_name = "healthcarelab"
  azure_location     = "East Asia"
  azure_k8s_version  = "1.21.1"
  domain             = var.domain
}

module "setup_infrastructures" {
  source = "./modules/infrastructures"
  kubernetes = {
    host                   = module.aks_cluster.host
    client_key             = base64decode(module.aks_cluster.client_key)
    client_certificate     = base64decode(module.aks_cluster.client_certificate)
    cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
  }
  domain = var.domain
}

# module "deploy_hapi_demo_application" {
#   source = "./modules/hapi-demo"
#   kubernetes = {
#     host                   = module.aks_cluster.host
#     client_key             = base64decode(module.aks_cluster.client_key)
#     client_certificate     = base64decode(module.aks_cluster.client_certificate)
#     cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
#     kube_config            = base64encode(module.aks_cluster.kube_config)
#   }
# }

output "ingress_ip_address" {
  value = module.setup_infrastructures.ingress_ip
}

