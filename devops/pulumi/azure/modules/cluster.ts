import * as containerservice from '@pulumi/azure-native/containerservice'
import * as k8s from '@pulumi/kubernetes'
import * as pulumi from '@pulumi/pulumi'
import * as azuread from '@pulumi/azuread'
import * as config from './config'
import { resourceGroup } from './resource-group'


// Create an AD service principal
const adApp = new azuread.Application(`${config.resourceGroupName}-ask-app`, {
  displayName: 'aks',
})

const adSp = new azuread.ServicePrincipal(`${config.resourceGroupName}-sp`, {
  applicationId: adApp.applicationId,
})

// Create the Service Principal Password
const adSpPassword = new azuread.ServicePrincipalPassword(`${config.resourceGroupName}-sp-pass`, {
  servicePrincipalId: adSp.id,
  value: config.password,
  endDate: '2099-01-01T00:00:00Z',
})

const k8sCluster = new containerservice.ManagedCluster('cluster', {
  resourceGroupName: resourceGroup.name,
  location: config.location,
  addonProfiles: {
    KubeDashboard: {
      enabled: false,
    },
  },
  agentPoolProfiles: [
    {
      count: config.nodeCount,
      maxPods: 110,
      osDiskSizeGB: 30,
      mode: 'System',
      name: 'agentpool',
      nodeLabels: {},
      osType: 'Linux',
      type: 'VirtualMachineScaleSets',
      vmSize: config.nodeSize,
    },
  ],
  linuxProfile: {
    adminUsername: config.adminUserName,
    ssh: {
      publicKeys: [
        {
          keyData: config.sshPublicKey,
        },
      ],
    },
  },
  servicePrincipalProfile: {
    clientId: adApp.applicationId,
    secret: adSpPassword.value,
  },
  dnsPrefix: resourceGroup.name,
  enableRBAC: true,
  kubernetesVersion: config.k8sVersion,
  nodeResourceGroup: `${resourceGroup.name}-aks-node`,
}, {dependsOn: [resourceGroup]})

const creds = pulumi.all([k8sCluster.name, resourceGroup.name]).apply(([clusterName, rgName]) => {
  return containerservice.listManagedClusterUserCredentials({
    resourceGroupName: rgName,
    resourceName: clusterName,
  })
})

export const kubeconfig = creds.kubeconfigs[0].value.apply(enc =>
  Buffer.from(enc, 'base64').toString(),
)

export const k8sProvider = new k8s.Provider('k8s-provider', {
  kubeconfig: kubeconfig,
})
