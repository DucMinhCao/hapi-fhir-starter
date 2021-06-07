{
  "version": 4,
  "terraform_version": "0.15.4",
  "serial": 35,
  "lineage": "ed27129a-c26e-dada-b429-c643605f2a35",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "k3d_cluster",
      "name": "mycluster",
      "provider": "provider[\"registry.terraform.io/3rein/k3d\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "agents": 2,
            "credentials": [
              {
                "client_certificate": "-----BEGIN CERTIFICATE-----\nMIIBkDCCATegAwIBAgIIcilpE/fS/IwwCgYIKoZIzj0EAwIwIzEhMB8GA1UEAwwY\nazNzLWNsaWVudC1jYUAxNjIyNzMzOTExMB4XDTIxMDYwMzE1MjUxMVoXDTIyMDYw\nMzE1MjUxMVowMDEXMBUGA1UEChMOc3lzdGVtOm1hc3RlcnMxFTATBgNVBAMTDHN5\nc3RlbTphZG1pbjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABDWtKRQ/NBr3XU9I\nS3vVfgQ2xleMKC5wldwIRNw9BZlJpebyN7ugcSJ1oswfyzPjYnrXuOBYmfBjHOFd\noWzMO/ajSDBGMA4GA1UdDwEB/wQEAwIFoDATBgNVHSUEDDAKBggrBgEFBQcDAjAf\nBgNVHSMEGDAWgBRdX8FXpYIgLsjs1iud0PrXoBxWcTAKBggqhkjOPQQDAgNHADBE\nAiBfH0KyU/KD/gECFSrkMz+ql3krZV2ypOPTO6NWaO9WBgIgMiDRKzLG6JC5ucpO\nDMoRgVWQ9wndEu4QOFyqBRj78AM=\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIBdjCCAR2gAwIBAgIBADAKBggqhkjOPQQDAjAjMSEwHwYDVQQDDBhrM3MtY2xp\nZW50LWNhQDE2MjI3MzM5MTEwHhcNMjEwNjAzMTUyNTExWhcNMzEwNjAxMTUyNTEx\nWjAjMSEwHwYDVQQDDBhrM3MtY2xpZW50LWNhQDE2MjI3MzM5MTEwWTATBgcqhkjO\nPQIBBggqhkjOPQMBBwNCAAT+b85v+NVu0Hb4XSGEytFWPtC+ZKkuOeoDsCrZA7i8\nTZtXYLBTX35yFJpid4UYT/wWeKNTbfWkM9qkTtT+1XGLo0IwQDAOBgNVHQ8BAf8E\nBAMCAqQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUXV/BV6WCIC7I7NYrndD6\n16AcVnEwCgYIKoZIzj0EAwIDRwAwRAIgKWqTiqKuY7ppx9EkAZ9JmF6gZ2HiQyWR\nSYOo1wlr7n4CIF3FvBN7Gvjh76xwmEcoNyQNDpoCycf26m09DYL1j/JH\n-----END CERTIFICATE-----\n",
                "client_key": "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIH4bw1oDmDanQmWZD/uyHbOSXI3BJ3jGDllNtiuxctFUoAoGCCqGSM49\nAwEHoUQDQgAENa0pFD80GvddT0hLe9V+BDbGV4woLnCV3AhE3D0FmUml5vI3u6Bx\nInWizB/LM+Niete44FiZ8GMc4V2hbMw79g==\n-----END EC PRIVATE KEY-----\n",
                "cluster_ca_certificate": "-----BEGIN CERTIFICATE-----\nMIIBdzCCAR2gAwIBAgIBADAKBggqhkjOPQQDAjAjMSEwHwYDVQQDDBhrM3Mtc2Vy\ndmVyLWNhQDE2MjI3MzM5MTEwHhcNMjEwNjAzMTUyNTExWhcNMzEwNjAxMTUyNTEx\nWjAjMSEwHwYDVQQDDBhrM3Mtc2VydmVyLWNhQDE2MjI3MzM5MTEwWTATBgcqhkjO\nPQIBBggqhkjOPQMBBwNCAAQoHdJCiiPrGs+oKw96bFJIqOGm7kec/xPq86Hoxtwk\n9dPUgcBRNVpvbDqO2R0CIFKaKnlfSGRxjzUZTqsqdWXho0IwQDAOBgNVHQ8BAf8E\nBAMCAqQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUOWbRkKqPoNb39lMcQ0pC\ncK2A/powCgYIKoZIzj0EAwIDSAAwRQIhANeLbmTy4oMIvxflsVQ6Y/BI3E02QE6l\n9mtLXc8U/z4bAiALaNccGTK8jqu1ZNrqrYMFk9kfB8+9RzPxTSOCrjJTgg==\n-----END CERTIFICATE-----\n",
                "host": "https://localhost:6445",
                "raw": "apiVersion: v1\nclusters:\n- cluster:\n    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkekNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUyTWpJM016TTVNVEV3SGhjTk1qRXdOakF6TVRVeU5URXhXaGNOTXpFd05qQXhNVFV5TlRFeApXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUyTWpJM016TTVNVEV3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFRb0hkSkNpaVByR3Mrb0t3OTZiRkpJcU9HbTdrZWMveFBxODZIb3h0d2sKOWRQVWdjQlJOVnB2YkRxTzJSMENJRkthS25sZlNHUnhqelVaVHFzcWRXWGhvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVU9XYlJrS3FQb05iMzlsTWNRMHBDCmNLMkEvcG93Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUloQU5lTGJtVHk0b01JdnhmbHNWUTZZL0JJM0UwMlFFNmwKOW10TFhjOFUvejRiQWlBTGFOY2NHVEs4anF1MVpOcnFyWU1GazlrZkI4KzlSelB4VFNPQ3JqSlRnZz09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K\n    server: https://localhost:6445\n  name: k3d-mycluster\ncontexts:\n- context:\n    cluster: k3d-mycluster\n    user: admin@k3d-mycluster\n  name: k3d-mycluster\ncurrent-context: k3d-mycluster\nkind: Config\npreferences: {}\nusers:\n- name: admin@k3d-mycluster\n  user:\n    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJrRENDQVRlZ0F3SUJBZ0lJY2lscEUvZlMvSXd3Q2dZSUtvWkl6ajBFQXdJd0l6RWhNQjhHQTFVRUF3d1kKYXpOekxXTnNhV1Z1ZEMxallVQXhOakl5TnpNek9URXhNQjRYRFRJeE1EWXdNekUxTWpVeE1Wb1hEVEl5TURZdwpNekUxTWpVeE1Wb3dNREVYTUJVR0ExVUVDaE1PYzNsemRHVnRPbTFoYzNSbGNuTXhGVEFUQmdOVkJBTVRESE41CmMzUmxiVHBoWkcxcGJqQlpNQk1HQnlxR1NNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJEV3RLUlEvTkJyM1hVOUkKUzN2VmZnUTJ4bGVNS0M1d2xkd0lSTnc5QlpsSnBlYnlON3VnY1NKMW9zd2Z5elBqWW5yWHVPQlltZkJqSE9GZApvV3pNTy9halNEQkdNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBakFmCkJnTlZIU01FR0RBV2dCUmRYOEZYcFlJZ0xzanMxaXVkMFByWG9CeFdjVEFLQmdncWhrak9QUVFEQWdOSEFEQkUKQWlCZkgwS3lVL0tEL2dFQ0ZTcmtNeitxbDNrclpWMnlwT1BUTzZOV2FPOVdCZ0lnTWlEUkt6TEc2SkM1dWNwTwpETW9SZ1ZXUTl3bmRFdTRRT0Z5cUJSajc4QU09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkakNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdFkyeHAKWlc1MExXTmhRREUyTWpJM016TTVNVEV3SGhjTk1qRXdOakF6TVRVeU5URXhXaGNOTXpFd05qQXhNVFV5TlRFeApXakFqTVNFd0h3WURWUVFEREJock0zTXRZMnhwWlc1MExXTmhRREUyTWpJM016TTVNVEV3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFUK2I4NXYrTlZ1MEhiNFhTR0V5dEZXUHRDK1pLa3VPZW9Ec0NyWkE3aTgKVFp0WFlMQlRYMzV5RkpwaWQ0VVlUL3dXZUtOVGJmV2tNOXFrVHRUKzFYR0xvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVVhWL0JWNldDSUM3STdOWXJuZEQ2CjE2QWNWbkV3Q2dZSUtvWkl6ajBFQXdJRFJ3QXdSQUlnS1dxVGlxS3VZN3BweDlFa0FaOUptRjZnWjJIaVF5V1IKU1lPbzF3bHI3bjRDSUYzRnZCTjdHdmpoNzZ4d21FY29OeVFORHBvQ3ljZjI2bTA5RFlMMWovSkgKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=\n    client-key-data: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUg0Yncxb0RtRGFuUW1XWkQvdXlIYk9TWEkzQkozakdEbGxOdGl1eGN0RlVvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFTmEwcEZEODBHdmRkVDBoTGU5VitCRGJHVjR3b0xuQ1YzQWhFM0QwRm1VbWw1dkkzdTZCeApJbldpekIvTE0rTmlldGU0NEZpWjhHTWM0VjJoYk13NzlnPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=\n"
              }
            ],
            "env": [],
            "id": "mycluster",
            "image": "rancher/k3s:latest",
            "k3d": [
              {
                "disable_host_ip_injection": false,
                "disable_image_volume": false,
                "disable_load_balancer": false
              }
            ],
            "k3s": [],
            "kube_api": [
              {
                "host": "localhost",
                "host_ip": "127.0.0.1",
                "host_port": 6445
              }
            ],
            "kubeconfig": [
              {
                "switch_current_context": true,
                "update_default_kubeconfig": true
              }
            ],
            "label": [],
            "name": "mycluster",
            "network": "my-custom-net",
            "port": [
              {
                "container_port": 80,
                "host": "",
                "host_port": 80,
                "node_filters": [
                  "loadbalancer"
                ],
                "protocol": ""
              },
              {
                "container_port": 433,
                "host": "",
                "host_port": 433,
                "node_filters": [
                  "loadbalancer"
                ],
                "protocol": ""
              }
            ],
            "registries": [],
            "runtime": [],
            "servers": 1,
            "token": "superSecretToken",
            "volume": []
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "null_resource",
      "name": "check_cluster_ready",
      "provider": "provider[\"registry.terraform.io/hashicorp/null\"]",
      "instances": [
        {
          "status": "tainted",
          "schema_version": 0,
          "attributes": {
            "id": "3068341302397625430",
            "triggers": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA==",
          "dependencies": [
            "k3d_cluster.mycluster"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "null_resource",
      "name": "deploy_traefik_dashboards",
      "provider": "provider[\"registry.terraform.io/hashicorp/null\"]",
      "instances": [
        {
          "status": "tainted",
          "schema_version": 0,
          "attributes": {
            "id": "5177834681312024019",
            "triggers": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "module": "module.deploy_argo",
      "mode": "managed",
      "type": "helm_release",
      "name": "deploy-argo-cd",
      "provider": "provider[\"registry.terraform.io/hashicorp/helm\"]",
      "instances": []
    },
    {
      "module": "module.deploy_argo",
      "mode": "managed",
      "type": "helm_release",
      "name": "deploy-argo-events",
      "provider": "provider[\"registry.terraform.io/hashicorp/helm\"]",
      "instances": []
    },
    {
      "module": "module.deploy_argo",
      "mode": "managed",
      "type": "helm_release",
      "name": "deploy-argo-workflows",
      "provider": "provider[\"registry.terraform.io/hashicorp/helm\"]",
      "instances": []
    },
    {
      "module": "module.deploy_argo",
      "mode": "managed",
      "type": "kubernetes_ingress",
      "name": "deploy_ingress_argocd",
      "provider": "provider[\"registry.terraform.io/hashicorp/kubernetes\"]",
      "instances": []
    }
  ]
}
