// Parameters allow for flexibility during deployment
param storageAccountName string = 'st${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param skuName string = 'Standard_LRS'

// The Storage Account resource definition
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

// Output the primary endpoint for reference
output storageId string = storageAccount.id
output primaryEndpoints object = storageAccount.properties.primaryEndpoints
