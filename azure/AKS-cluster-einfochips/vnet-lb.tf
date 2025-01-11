
# Virtual Network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "sa1-test-eic-SudarshanDarade-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Environment         = "dev"
    "Business Owner"    = "Chirag.Gandhi@einfochips.com"
    "Business Unit"     = "einfochips"
    "Environment Type"  = "Test"
    "Project Name"      = "Training and Learning purpose"
    "RG Owner"          = "Sudarshan.Darade@einfochips.com"
    "Sub Business Unit" = "PES - IA"
  }
}

# Subnets
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "lb_subnet" {
  name                 = "lb-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}

# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_pip" {
  name                = "sa1_test_eic_SudarshanDarade-lb-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    "Business Owner"    = "Chirag.Gandhi@einfochips.com"
    "Business Unit"     = "einfochips"
    "Environment Type"  = "Test"
    "Project Name"      = "Training and Learning purpose"
    "RG Owner"          = "Sudarshan.Darade@einfochips.com"
    "Sub Business Unit" = "PES - IA"
  }
}

# Load Balancer
resource "azurerm_lb" "aks_lb" {
  name                = "sa1_test_eic_SudarshanDarade-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
  tags = {
    "Business Owner"    = "Chirag.Gandhi@einfochips.com"
    "Business Unit"     = "einfochips"
    "Environment Type"  = "Test"
    "Project Name"      = "Training and Learning purpose"
    "RG Owner"          = "Sudarshan.Darade@einfochips.com"
    "Sub Business Unit" = "PES - IA"
  }
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "aks_pool" {
  loadbalancer_id = azurerm_lb.aks_lb.id
  name            = "aks-backend-pool"
}