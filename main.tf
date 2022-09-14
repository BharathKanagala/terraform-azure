# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "spring_tf" {
  name     = "SpringBootResourceGroup"
  location = "westus2"
}

resource "azurerm_container_group" "spring_cg" {
  location            = azurerm_resource_group.spring_tf.location
  name                = "api_hello"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.spring_tf.name
  ip_address_type     = "Public"
  dns_name_label      = "hello"
  container {
    cpu    = 1
    image  = "k777/petclinic"
    memory = 1
    name   = "springapi"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

