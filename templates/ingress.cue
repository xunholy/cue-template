package templates

import networkingv1 "k8s.io/api/networking/v1"

#IngressListTemplate: {
	config: #Config
	items: [...networkingv1.#Ingress & {
		apiVersion: "v1"
		kind:       "Ingress"
	}]
	items: [ for ingressName, ingressConfig in config.ingress if ingressConfig.enabled {
		metadata: {
			config.metadata
			labels:      ingressConfig.labels
			labels:      config.global.labels
			annotations: ingressConfig.annotations
			annotations: config.global.annotations
		}
		spec: ingressClassName: ingressConfig.ingressClassName
		spec: tls: [{
			hosts: [ for hostConfig in ingressConfig.hosts {
				hostConfig.host
			}]
			secretName: ingressConfig.secretName
		}]
		spec: rules: [ for hostConfig in ingressConfig.hosts {
			host: hostConfig.host
			http: paths: [ for hostPathConfig in hostConfig.paths {
				path:     hostPathConfig.path
				pathType: hostPathConfig.pathType
				backend: service: name: config.metadata.name
				// backend: service: port: number: config.service.ports[0]
			}]
		}]
	}]
}
