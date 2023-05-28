package templates

import appsv1 "k8s.io/api/apps/v1"

#DaemonSetTemplate: {
	config: #Config
	if (config.controller & #DaemonSetConfig) != _|_ && config.controller.enabled {
		template: appsv1.#DaemonSet & {
			apiVersion: "apps/v1"
			kind:       "DaemonSet"
			metadata:   config.metadata
			metadata: annotations: config.controller.annotations
			metadata: labels:      config.controller.labels
			spec: {
				selector: matchLabels: config.metadataSpec.selectorLabels

				let _config = config

				let pod = #PodTemplate & {config: _config}
				template: pod.template
			}
		}
	}
}
