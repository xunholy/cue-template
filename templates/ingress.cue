package templates

import (
	netv1 "k8s.io/api/networking/v1"
)

#Ingress: netv1.#Ingress & {
	_config: #Config

	apiVersion: "v1"
	kind:       "Ingress"
	metadata:   _config.metadata

	spec: {}
}
