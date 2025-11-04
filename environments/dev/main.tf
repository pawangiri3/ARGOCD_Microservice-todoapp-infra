locals {
  common_tags = {
    ManagedBy   = "Terraform"
    Environment = "dev"
    Owner       = "TodoTeam"
  }
}


module "resource_groups" {
  source = "../../modules/resource_group"
  rgs    = var.rgs
  tags   = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrpawantodoapp01"
  rg_name    = "pawan_Argocd1"
  location   = "centralindia"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-pawan-todoapp-01"
  rg_name         = "pawan_Argocd1"
  location        = "centralindia"
  admin_username  = "pawanopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-pawan-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  source = "../../modules/aks"

  aks_clusters = var.aks_clusters
  common_tags  = var.common_tags
}


module "pip" {
  source   = "../../modules/azurerm_public_ip"
  pip_name = "pip-pawan-todoapp"
  rg_name  = "pawan_Argocd1"
  location = "centralindia"
  sku      = "Basic"
  tags     = local.common_tags
}
