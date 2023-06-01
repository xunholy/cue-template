package templates

import corev1 "k8s.io/api/core/v1"

#ConfigMapListTemplate: {
	config: #Config
	template: [...corev1.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
	template: [{
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
