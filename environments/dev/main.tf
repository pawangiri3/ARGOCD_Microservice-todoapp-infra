locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "pawan"
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
      rg_name     = "pawan_final_argo"
      rg_location = "centralindia"
      rg_tags     = local.common_tags
}


module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrpawantodoapp01oldwali"
  rg_name    = "pawan_final_argo"
  location   = "centralindia"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-pawan-todoapp-try01"
  rg_name         = "pawan_final_argo"
  location        = "centralindia"
  admin_username  = "pawanopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-pawan-todoapp-try01"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aks-pawan-todoapp"
  location   = "centralindia"
  rg_name    = "pawan_final_argo"
  dns_prefix = "aks-pawan-todoapp"
  tags       = local.common_tags
}


# module "pip" {
#   source   = "../../modules/azurerm_public_ip"
#   pip_name = "pip-pawan-todoapp"
#   rg_name  = "pawan_final_argo"
#   location = "centralindia"
#   sku      = "Basic"
#   tags     = local.common_tags
# }
