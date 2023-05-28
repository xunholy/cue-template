package templates

import appsv1 "k8s.io/api/apps/v1"

#DeploymentTemplate: {
	config: #Config
	if (config.controller & #DeploymentConfig) != _|_ && config.controller.enabled {
		template: appsv1.#Deployment & {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata:   config.metadata
			metadata: annotations: config.controller.annotations
			metadata: labels:      config.controller.labels
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
		}
	}
}
