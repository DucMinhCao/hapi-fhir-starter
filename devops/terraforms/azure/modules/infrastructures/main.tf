terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.3.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.2"
    }
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = "0.4.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

variable "project_name" {
  type    = string
  default = "healthcarelab"
}

variable "k8s_version" {
  type    = string
  default = "1.2.1"
}

variable "kubernetes" {
  type = object({
    host                   = string
    client_key             = string
    client_certificate     = string
    cluster_ca_certificate = string
  })
}

variable "kube_config" {
  type = string
}


provider "kubernetes-alpha" {
  host                   = var.kubernetes.host
  client_key             = var.kubernetes.client_key
  client_certificate     = var.kubernetes.client_certificate
  cluster_ca_certificate = var.kubernetes.cluster_ca_certificate
  config_path            = "${path.root}/kubeconfig"
}

provider "kubernetes" {
  host                   = var.kubernetes.host
  client_key             = var.kubernetes.client_key
  client_certificate     = var.kubernetes.client_certificate
  cluster_ca_certificate = var.kubernetes.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = var.kubernetes.host
    client_key             = var.kubernetes.client_key
    client_certificate     = var.kubernetes.client_certificate
    cluster_ca_certificate = var.kubernetes.cluster_ca_certificate
  }
}
