resource "linode_lke_cluster" "my_cluster" {
  label       = var.clusterName
  k8s_version = var.k8s_version
  region      = var.region
  tags        = ["production", "kubernetes"]

  pool {
    type  = var.nodeType
    count = 3
    # Optional: autoscaler configuration
    autoscaler {
      min = 3
      max = 3
    }
  }
  control_plane {
    high_availability = false
  }
}
# # Output the kubeconfig
# output "kubeconfig" {
#   value     = linode_lke_cluster.my_cluster.kubeconfig
#   sensitive = true
# }

# # Output the API endpointz
# output "api_endpoints" {
#   value = linode_lke_cluster.my_cluster.api_endpoints
# }

# # Output the status of the cluster
# output "status" {
#   value = linode_lke_cluster.my_cluster.status
# }

# # Output the node pool IDs
# output "pool_ids" {
#   value = linode_lke_cluster.my_cluster.pool.*.id
# }