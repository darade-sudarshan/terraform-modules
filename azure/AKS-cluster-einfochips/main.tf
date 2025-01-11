# 1. Terraform Settings Block
terraform {
  # 1. Required Version Terraform
  required_version = ">= 1.0"
  # 2. Required Terraform Providers  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "~> 3.0"
    # }
  }
}
provider "azurerm" {
  features {}
  # client_id = ""
  # client_secret = ""
  tenant_id                       = "0adb040b-ca22-4ca6-9447-ab7b049a22ff"
  subscription_id                 = "664b6097-19f2-42a3-be95-a4a6b4069f6b"
  resource_provider_registrations = "none"
}
