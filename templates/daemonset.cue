package templates

import appsv1 "k8s.io/api/apps/v1"

#DaemonSetListTemplate: {
	config: #Config
	items: [...appsv1.#DaemonSet & {
		apiVersion: "apps/v1"
		kind:       "DaemonSet"
	}]
	items: [ if (config.controller & #DaemonSetConfig) != _|_ && config.controller.enabled {
		metadata: {
			config.metadata
			labels:      config.controller.labels
			labels:      config.global.labels
			annotations: config.controller.annotations
			annotations: config.global.annotations
		}
		spec: {
			// selector: matchLabels: config.metadataSpec.selectorLabels

			let _config = config

			let pod = #PodTemplate & {config: _config}
			template: pod.template
		}
	}]
}
