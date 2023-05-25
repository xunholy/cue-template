package ingresses

import (
	netv1 "k8s.io/api/networking/v1"
	i "timoni.sh/templates/inputs"
)

#Ingress: netv1.#Ingress & {
	_config: i.#Config

	apiVersion: "v1"
	kind:       "Ingress"
	metadata: _config.metadata
	spec: {}
		// _config.ingress.ingressClassName
		// tls: [{
		// 	hosts: []
		// 	secretName: _config.ingress.ingressClassName
		// }]
}
