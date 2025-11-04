variable "aks_clusters" {
  description = "Map of AKS cluster configurations"
  type = map(object({
    aks_name     = string
    location     = string
    rg_name      = string
    dns_prefix   = string
    tags         = optional(map(string))

    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
    })

    additional_pools = optional(list(object({
      name       = string
      node_count = number
      vm_size    = string
      mode       = optional(string)
    })))

    identity = optional(object({
      type = string
    }))

    network_profile = optional(object({
      network_plugin    = optional(string)
      load_balancer_sku = optional(string)
      dns_service_ip    = optional(string)
      service_cidr      = optional(string)
    }))
  }))
}

variable "common_tags" {
  description = "Common tags for all AKS resources"
  type        = map(string)
  default     = {}
}
