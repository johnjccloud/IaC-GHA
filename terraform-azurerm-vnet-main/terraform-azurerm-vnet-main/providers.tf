provider "azurerm" {   
    subscription_id = secrets.ARM_SUBSCRIPTION_ID
    client_id = secrets.ARM_CLIENT_ID
    client_secret = secrets.ARM_CLIENT_SECRET   
    tenant_id = secrets.ARM_TENANT_ID   
    features {} 
    }