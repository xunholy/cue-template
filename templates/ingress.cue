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
				labels:      ingressConfig.labels
				labels:      config.global.labels
				annotations: config.controller.annotations
				annotations: config.global.annotations
		}
		spec: ingressClassName: ingressConfig.ingressClassName
		// spec: tls: [ for ingressHosts in ingressConfig.tls {
		// 	hosts: [{
		// 		ingressHosts
		// 	}]
		// 	secretName: ingressHosts.secretName
		// }]
		// spec: rules: [{
		// 	host: ""
		// 	http: paths: [{
		// 		path:     ""
		// 		pathType: ""
		// 		backend: service: name: ""
		// 		backend: service: port: number: 1
		// 	}]
		// }]
	}]
}
