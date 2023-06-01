package templates

import appsv1 "k8s.io/api/apps/v1"

#StatefulSetListTemplate: {
	config: #Config
	let _controller = config.controller
	if (_controller & #StatefulSetConfig) != _|_ && config.controller.enabled {
		template: [...appsv1.#StatefulSet & {
			apiVersion: "apps/v1"
			kind:       "StatefulSet"
		}]
		template: [{
			metadata: {
				config.metadata
				labels:      config.controller.labels
				labels:      config.global.labels
				annotations: config.controller.annotations
				annotations: config.global.annotations
			}
			spec: {
				replicas: config.controller.replicas

				let _config = config

				let pod = #PodTemplate & {config: _config}
				template: pod.template

				serviceName: config.metadata.name
				updateStrategy: type: config.controller.strategy
			}
		}]
	}
}
