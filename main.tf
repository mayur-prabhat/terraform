terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
}

provider "azurerm" {
  features {}


}
resource "azurerm_resource_group" "mayur" {
  name     = "api-rg-pro"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "mayur" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.mayur.location
  resource_group_name = azurerm_resource_group.mayur.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_app_service" "mayur" {
  name                = "mayur-app-service"
  location            = azurerm_resource_group.mayur.location
  resource_group_name = azurerm_resource_group.mayur.name
  app_service_plan_id = azurerm_app_service_plan.mayur.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

resource "azurerm_storage_account" "mayur" {
  name                     = "imayurstaragwe"
  resource_group_name      = azurerm_resource_group.mayur.name
  location                 = azurerm_resource_group.mayur.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "monty"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.dev_var
  location = "West Europe"
}
resource "azurerm_resource_group" "rg2" {
  name     = var.qa_var
  location = "West Europe"
}