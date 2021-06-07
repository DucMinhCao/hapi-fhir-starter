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

resource "azurerm_resource_group" "healthcarelab_resource_group" {
  name     = "${var.azure_project_name}_resource_group"
  location = var.azure_location
  tags = {
    Environment = var.environment
    Source      = "terraform"
  }
}

resource "azurerm_container_registry" "healthcarelab_arc" {
  name                = "${var.azure_project_name}acr"
  resource_group_name = azurerm_resource_group.healthcarelab_resource_group.name
  location            = azurerm_resource_group.healthcarelab_resource_group.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "healthcarelab_cluster" {
  name                = "${var.azure_project_name}_aks_cluster"
  location            = azurerm_resource_group.healthcarelab_resource_group.location
  resource_group_name = azurerm_resource_group.healthcarelab_resource_group.name
  dns_prefix          = "${var.azure_project_name}-dns"
  kubernetes_version  = var.azure_k8s_version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b4ms"
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

// Create local kubeconfig
resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.healthcarelab_cluster]
  filename   = "kubeconfig"
  content    = azurerm_kubernetes_cluster.healthcarelab_cluster.kube_config_raw
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

output "container_registry" {
  value = azurerm_container_registry.healthcarelab_arc
}

