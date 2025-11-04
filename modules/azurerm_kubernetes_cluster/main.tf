resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aks_clusters

  name                = each.value.aks_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  dns_prefix          = each.value.dns_prefix

  # Default Node Pool
  default_node_pool {
    name       = each.value.default_node_pool.name
    node_count = each.value.default_node_pool.node_count
    vm_size    = each.value.default_node_pool.vm_size
  }

  # Optional - Additional Node Pools
  dynamic "agent_pool_profile" {
    for_each = lookup(each.value, "additional_pools", [])
    content {
      name       = agent_pool_profile.value.name
      node_count = agent_pool_profile.value.node_count
      vm_size    = agent_pool_profile.value.vm_size
      mode       = lookup(agent_pool_profile.value, "mode", "User")
    }
  }

  # Optional - Identity
  dynamic "identity" {
    for_each = lookup(each.value, "identity", { type = "SystemAssigned" }) != null ? [lookup(each.value, "identity", { type = "SystemAssigned" })] : []
    content {
      type = identity.value.type
    }
  }

  # Optional - Network Profile
  dynamic "network_profile" {
    for_each = lookup(each.value, "network_profile", null) != null ? [each.value.network_profile] : []
    content {
      network_plugin    = lookup(network_profile.value, "network_plugin", null)
      load_balancer_sku = lookup(network_profile.value, "load_balancer_sku", null)
      dns_service_ip    = lookup(network_profile.value, "dns_service_ip", null)
      service_cidr      = lookup(network_profile.value, "service_cidr", null)
    }
  }

  # Tags
  tags = merge(var.common_tags, lookup(each.value, "tags", {}))
}
