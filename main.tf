provider "azurerm"{
    version = "2.2.0"
    features {}
}

resource "azurerm_resource_group" "applicazione" {
  name     = "applicazione-gruppo"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "applicazione" {
  name                = "applicazione-appserviceplan"
  location            = azurerm_resource_group.applicazione.location
  resource_group_name = azurerm_resource_group.applicazione.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "applicazione" {
  name                = "applicazione-appservice"
  location            = azurerm_resource_group.applicazione.location
  resource_group_name = azurerm_resource_group.applicazione.name
  app_service_plan_id = azurerm_app_service_plan.applicazione.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" ="10.15.2"
    "ApiUrl" =""
    "ApiUrlShoppingCart"=""
    "MongoConnectionString" = ""
    "SqlConnectionString" = ""
    "productImagesUrl" = "https://raw.githubusercontent.com/microsoft/TailwindTraders-Backend/master/Deploy/tailwindtraders-images/product-detail"
    "Personalizer__ApiKey"=""
    "Personalizer__Endpoint"=""
  }

  
}