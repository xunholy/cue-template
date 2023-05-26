package templates

import corev1 "k8s.io/api/core/v1"

#PodTemplate: {
	config:   #Config
	template: corev1.#PodTemplateSpec & {
		metadata: {
			labels: config.controller.labels
			// annotations: config.metadata.annotations
		}
		spec: config.pod & {containers: [{
			name:  "\(config.metadata.name)"
			image: "\(config.image.repository):\(config.image.tag)"
		}]
		}
	}
}
