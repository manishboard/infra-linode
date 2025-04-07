variable "linode_api_token" {
  description = "Your Linode API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region where the cluster will be deployed"
  type        = string
}

variable "k8s_version" {
  description = "The Kubernetes version to use"
  type        = string
}

variable "clusterName" {
  description = "The Name for the Kubernetes cluster"
  type        = string
}

variable "nodeType" {
  description = "The nodeType of the cluster"
  type        = string
}