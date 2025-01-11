resource "azurerm_resource_group" "rg" {
  name     = "sa1_test_eic_SudarshanDarade"
  location = "Southeast Asia"
  tags = {
    "Business Owner"    = "Chirag.Gandhi@einfochips.com"
    "Business Unit"     = "einfochips"
    "End Date RG"       = "30-Jun-2025"
    "Environment Type"  = "Test"
    "Project Name"      = "Training and Learning purpose"
    "RG Create"         = "25-Oct-2024"
    "RG Owner"          = "Sudarshan.Darade@einfochips.com"
    "Sub Business Unit" = "PES - IA"
    "Task #"            = "SCTASK0638064"
  }
}

