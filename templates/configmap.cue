package templates

import (
	corev1 "k8s.io/api/core/v1"
)

#ConfigMap: corev1.#ConfigMap & {
	_config: #Config

	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: _config.metadata

	immutable: _config.configmap.immutable
	data: _config.configmap.data
}
