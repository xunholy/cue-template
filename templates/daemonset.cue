package templates

import (
	appsv1 "k8s.io/api/apps/v1"
)

#DaemonSet: appsv1.#DaemonSet & {
	_config: #Config

	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata:   _config.metadata

	// https://pkg.go.dev/k8s.io/api/apps/v1#DaemonSetSpec
	spec: appsv1.#DaemonSetSpec & {
		selector: matchLabels: _config.metadata.labels
		template: {
			metadata: {
				annotations: _config.metadata.annotations
				labels:      _config.controller.labels
			}
			#PodTemplateSpec
		}
	}
}
