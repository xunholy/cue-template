package templates

import networkingv1 "k8s.io/api/networking/v1"

#IngressListTemplate: {
	config: #Config
	template: [...networkingv1.#Ingress & {
		apiVersion: "v1"
		kind:       "Ingress"
	}]
	template: [ for ingressName, ingressConfig in config.ingress if ingressConfig.enabled {
		metadata: {
			config.metadata
			annotations: ingressConfig.annotations
			annotations: config.global.annotations
		}
		spec: ingressClassName: ingressConfig.ingressClassName
		spec: tls: [{
			hosts: []
			secretName: ""
		}]
		spec: rules: [{
			host: ""
			http: paths: [{
				path:     ""
				pathType: ""
				backend: service: name: ""
				backend: service: port: number: 1
			}]
		}]
	}]
}
