variable "namespace" {
  description = "The namespace in which Github Actions Self Hosted will be deployed."
  type        = string
  default     = "ngrok"
}

variable "deploy_version" {
  description = "The version of Github Actions Self Hosted."
  type        = string
  default     = "0.02"
}
