import * as pulumi from '@pulumi/pulumi'
import * as random from '@pulumi/random'
import * as tls from '@pulumi/tls'

const config = new pulumi.Config()

export const k8sVersion = config.get('k8sVersion') || '1.21.1'

export const password = config.get('password') || new random.RandomPassword('pw', {
    length: 20,
    special: true,
}).result

export const generatedKeyPair = new tls.PrivateKey('ssh-key', {
    algorithm: 'RSA',
    rsaBits: 4096,
})

export const adminUserName = config.get('adminUserName') || 'admin'

export const sshPublicKey = config.get('sshPublicKey') || generatedKeyPair.publicKeyOpenssh

export const nodeCount = config.getNumber('nodeCount') || 1

export const nodeSize = config.get('nodeSize') || 'standard_b4ms'

export const location = config.get('location') || 'eastasia'

export const resourceGroupName = config.get('resource_group') || 'healthcaredc'

export const domain = config.get('domain') || 'ohmydev.asia'
