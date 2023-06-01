package templates

import "k8s.io/api/core/v1"

#ConfigMapListTemplate: {
	config: #Config
	items: [...v1.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
	items: [{
		metadata: {
			config.metadata
			labels:      config.controller.labels
			labels:      config.global.labels
			annotations: config.controller.annotations
			annotations: config.global.annotations
		}
		immutable: config.configmap.immutable
		data:      config.configmap.data
	}]
}
