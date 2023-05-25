package templates

import (
	appsv1 "k8s.io/api/apps/v1"
)

#StatefulSet: appsv1.#StatefulSet & {
	_config: #Config

	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	metadata:   _config.metadata

	spec: {
		replicas: _config.controller.replicas
		selector: matchLabels: _config.metadata.labels
		template: {
			metadata: {
				annotations: _config.metadata.annotations
				labels:      _config.controller.labels
			}
			#PodTemplateSpec
		}
		updateStrategy: type: _config.controller.strategy
	}
}
