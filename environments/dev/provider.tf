terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Pawan_Argocd"
    storage_account_name = "argocdtodotest"
    container_name       = "argocd"
    key                  = "argocd.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "6dbc33a2-5da4-4090-8ac2-b8dde7d2a834"
}
