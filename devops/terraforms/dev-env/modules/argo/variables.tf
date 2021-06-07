variable "argo_namespace" {
  description = "The namespace in which Argo CD will be deployed."
  type        = string
  default     = "argocd"
}

variable "argo_cd_version" {
  description = "The version of Argo CD."
  type        = string
  default     = "3.6.1"
}

variable "argo_workflow_version" {
  description = "The version of Argo Workflow."
  type        = string
  default     = "0.1.3"
}

variable "argo_events_version" {
  description = "The version of Argo Workflow."
  type        = string
  default     = "1.4.2"
}
