package templates

import "k8s.io/api/core/v1"

#PodTemplate: {
	config:   #Config
	template: v1.#PodTemplateSpec & {
		// metadata: labels: config.controller.labels
		// metadata: annotations: config.metadata.annotations
		spec: config.pod & {
			containers: [{
				name:  config.metadata.name
				image: "\(config.image.repository):\(config.image.tag)"
			}]
			nodeSelector: config.nodeSelector
		}
	}
}
