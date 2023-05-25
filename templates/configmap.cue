package templates

import "k8s.io/api/core/v1"

#ConfigMapTemplate: {
	config:   #Config
	template: v1.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata:   config.metadata
		immutable:  config.configmap.immutable
		data:       config.configmap.data
	}
}
