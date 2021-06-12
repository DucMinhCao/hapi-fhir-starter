import * as azure from '@pulumi/azure'
import * as azureNative from '@pulumi/azure-native'
import { resourceGroup } from './resource-group'
import * as config from './config'


export const dnsZone = new azure.dns.Zone(`${config.resourceGroupName}-dns-zone`, {
  resourceGroupName: resourceGroup.name,
  name: config.domain,
}, {dependsOn: [resourceGroup]})

export const publicIPResource = new azureNative.network.PublicIPAddress(`${resourceGroup.name}-ip`, {
  dnsSettings: {
      domainNameLabel: resourceGroup.name,
  },
  location: config.location,
  publicIpAddressName: `${resourceGroup.name}-public-ip`,
  resourceGroupName: resourceGroup.name,
}, { dependsOn: [resourceGroup] })

export const publicIPAddress = publicIPResource.ipAddress.apply((ip) => ip)

export const domainRecord = publicIPResource.ipAddress.apply((publicIPAddress) => {
  return new azureNative.network.RecordSet('*', {
    aRecords: [{
      ipv4Address: publicIPAddress,
    }],
    recordType: 'A',
    resourceGroupName: resourceGroup.name,
    ttl: 3600,
    zoneName: dnsZone.name,
  }, {dependsOn: [dnsZone, publicIPResource]})

})

