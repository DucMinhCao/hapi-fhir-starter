variable "azure_location" {
  type    = string
  default = "East Asia"
}

variable "azure_project_name" {
  type    = string
  default = "healthcarelab"
}

variable "azure_k8s_version" {
  type    = string
  default = "1.21.1"
}

variable "environment" {
  type    = string
  default = "Production"
}

variable "aks_node_count" {
  type    = number
  default = 1
}

variable "aks_vm_type" {
  type    = string
  default = "standard_b4ms"
}

variable "domain" {
  type = string
}

resource "azurerm_resource_group" "healthcarelab_resource_group" {
  name     = "${var.azure_project_name}_resource_group"
  location = var.azure_location
  tags = {
    Environment = var.environment
    Source      = "terraform"
  }
}


# ----------------------------------------------------------------------------------------------------------------------
# Create AKS Cluster
# ----------------------------------------------------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster" "healthcarelab_cluster" {
  name                = "${var.azure_project_name}_aks_cluster"
  location            = azurerm_resource_group.healthcarelab_resource_group.location
  resource_group_name = azurerm_resource_group.healthcarelab_resource_group.name
  dns_prefix          = "${var.azure_project_name}-dns"
  kubernetes_version  = var.azure_k8s_version

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_type
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
    Source      = "Terraform"
  }

  addon_profile {

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }
}

data "azurerm_subscription" "current" {}

# Allow user assigned identity to read public IP from Healthcarelab Resources
resource "azurerm_role_assignment" "aks_user_assigned_network_contributor_role" {
  principal_id         = azurerm_kubernetes_cluster.healthcarelab_cluster.kubelet_identity.0.object_id
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, azurerm_resource_group.healthcarelab_resource_group.name)
  role_definition_name = "Network Contributor"
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config_raw
}

output "client_key" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config.0.cluster_ca_certificate
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config.0.password
}

output "host" {
  value = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config.0.host
}

output "main_resource_group" {
  value = azurerm_resource_group.healthcarelab_resource_group.name
}

#########################################################
#                        Output                         #
#########################################################
# Create local kubeconfig
resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.healthcarelab_cluster]
  filename   = "kubeconfig"
  content    = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config_raw
  lifecycle {
    prevent_destroy = true
  }
}
