import * as azure from '@pulumi/azure-native'
import * as config from './config'

export const resourceGroup = new azure.resources.ResourceGroup(config.resourceGroupName, {
  location: config.location,
})
