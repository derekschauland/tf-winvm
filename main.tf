terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  backend "remote" {
    organization = "derek2-training"
    workspaces {
      name = "tf-winvm"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

}

locals {
  tags = {
    owner       = var.owner
    environment = var.environment
    namespace   = var.namespace
  }
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"

}

resource "azurerm_resource_group" "this" {
  name     = "${module.naming.resource_group.name}-${var.location}-win-vm"
  location = var.location

  tags = local.tags
}

data "azurerm_client_config" "current" {}