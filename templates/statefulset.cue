package templates

import (
	appsv1 "k8s.io/api/apps/v1"
)

#StatefulSet : appsv1.#StatefulSet  & {
	_config: #Config

	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: _config.metadata

	// https://pkg.go.dev/k8s.io/api/apps/v1#DaemonSetSpec
	spec: appsv1.#StatefulSetSpec & {
		selector: matchLabels: _config.metadata.labels
		template: {
			metadata: {
				annotations: _config.metadata.annotations
				labels: _config.deployment.podLabels
			}
			#PodTemplateSpec
		}
	}
}
