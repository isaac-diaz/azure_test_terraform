terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscriptionID
  client_id = var.clientID
  client_secret = var.clientSecret
  tenant_id = var.tenantID

  features {}
}


resource "azurerm_resource_group" "gtest" {
  name     = "${var.RGName}"
  location =  "${var.location}"
}

resource "azurerm_kubernetes_cluster" "gtest_k8s_cluster" {
  name                = "gtest_k8s_cluster"
  location            = azurerm_resource_group.gtest.location
  resource_group_name = azurerm_resource_group.gtest.name
  dns_prefix          = "gtest_aks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.gtest_k8s_cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.gtest_k8s_cluster.kube_config_raw

  sensitive = true
}
