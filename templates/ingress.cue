package templates

import networkingv1 "k8s.io/api/networking/v1"

#IngressTemplate: {
	config: #Config
	if config.ingress.enabled {
		template: networkingv1.#Ingress & {
			apiVersion: "v1"
			kind:       "Ingress"
			metadata:   config.metadata
			metadata: annotations:  config.ingress.annotations

			spec: ingressClassName: config.ingress.ingressClassName
			spec: tls: [{
				hosts: []
				secretName: ""
			}]
			spec: rules: [{
				host: ""
				http: paths: [{
					path: ""
					pathType: ""
					backend: service: name: ""
					backend: service: port: number: 1
				}]

			}]
		}
	}
}
