# # Create Log Analytics Workspace
# resource "azurerm_log_analytics_workspace" "insights" {
#   name                = "logs-${random_id.random-id.hex}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "insights" {
  name                = "logs-aks-sa1-test-eic-SudarshanDarade"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  retention_in_days   = 30
  tags = {
    "Business Owner"    = "Chirag.Gandhi@einfochips.com"
    "Business Unit"     = "einfochips"
    "Environment Type"  = "Test"
    "Project Name"      = "Training and Learning purpose"
    "RG Owner"          = "Sudarshan.Darade@einfochips.com"
    "Sub Business Unit" = "PES - IA"
  }
}