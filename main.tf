terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }
}

provider "azurerm" {
  
  subscription_id = "${var.subscriptionID}"
  client_id = "${var.clientID}"
  client_secret = "${var.clientSecret}"
  tenant_id = "${var.tenantID}"

  features {}
}


resource "azurerm_resource_group" "gtest" {
  name     = "${var.RGName}"
  location =  "${var.location}"
}
