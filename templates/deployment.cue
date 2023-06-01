package templates

import appsv1 "k8s.io/api/apps/v1"

#DeploymentListTemplate: {
	config: #Config
	items: [...appsv1.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
	items: [ if (config.controller & #DeploymentConfig) != _|_ && config.controller.enabled {
		metadata: {
			config.metadata
			labels:      config.controller.labels
			labels:      config.global.labels
			annotations: config.controller.annotations
			annotations: config.global.annotations
		}
		spec: {
			replicas: config.controller.replicas
			strategy: {
				type:          config.controller.strategy
				rollingUpdate: config.controller.rollingUpdate
			}
			selector: matchLabels: config.metadataSpec.selectorLabels

			let _config = config

			let pod = #PodTemplate & {config: _config}
			template: pod.template
		}
	}]
}
