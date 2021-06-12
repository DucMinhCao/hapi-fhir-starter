import * as k8s from '@pulumi/kubernetes'
import * as config from './config'
import { k8sProvider } from './cluster'
import { publicIPAddress, publicIPResource } from './network'

const nginxNamespace = new k8s.core.v1.Namespace('ingress', {}, { provider: k8sProvider})

export const nginxIngressController = new k8s.helm.v3.Chart(
  'ingress-nginx',
  {
    chart: 'ingress-nginx',
    version: '3.32.0',
    fetchOpts: {repo: 'https://kubernetes.github.io/ingress-nginx'},
    namespace: nginxNamespace.metadata.name,
    values: {
      'controller.service.loadBalancerIP': publicIPAddress,
      'controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-resource-group"': config.resourceGroupName,
      'controller.service.type': 'LoadBalancer',
      'controller.service.externalTrafficPolicy': 'Local',
      'prometheus.create': true,
      'prometheus.port': 9901
    }
  },
  { provider: k8sProvider, dependsOn: [nginxNamespace, publicIPResource] },
)
