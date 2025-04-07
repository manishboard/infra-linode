terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.36.0"
    }
  }
}

provider "linode" {
  token = var.linode_api_token
}