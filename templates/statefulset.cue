package templates

import appsv1 "k8s.io/api/apps/v1"

#StatefulSetTemplate: {
	config: #Config
	let _controller = config.controller
	if (_controller & #StatefulSetConfig) != _|_ && config.controller.enabled {
		template: appsv1.#StatefulSet & {
			apiVersion: "apps/v1"
			kind:       "StatefulSet"
			metadata:   config.metadata
			metadata: annotations: config.controller.annotations
			metadata: labels:      config.controller.labels
			spec: {
				replicas: config.controller.replicas
				selector: matchLabels: config.metadataSpec.selectorLabels

				let _config = config

				let pod = #PodTemplate & {config: _config}
				template: pod.template

				serviceName: config.metadata.name
				updateStrategy: type: config.controller.strategy
			}
		}
	}
}
