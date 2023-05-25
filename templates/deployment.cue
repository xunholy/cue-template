package templates

import appsv1 "k8s.io/api/apps/v1"

#DeploymentTemplate: {
	config: #Config
	if (config.controller & #DeploymentConfig) != _|_ && config.controller.enabled {
		template: appsv1.#Deployment & {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata:   config.metadata
			spec: {
				replicas: config.controller.replicas
				strategy: {
					type:          config.controller.strategy
					rollingUpdate: config.controller.rollingUpdate
				}
				selector: matchLabels: config.controller.labels

				let pod = #PodTemplate & {config: config}
				template: pod.template
			}
		}
	}
}
