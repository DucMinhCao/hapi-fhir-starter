variable "namespace" {
  description = "The namespace in which Github Actions Self Hosted will be deployed."
  type        = string
  default     = "github-actions"
}

variable "deploy_version" {
  description = "The version of Github Actions Self Hosted."
  type        = string
  default     = "0.11.0"
}

variable "github_token" {
  type = string
}
