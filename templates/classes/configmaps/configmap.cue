package configmaps

import (
	// appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
	i "timoni.sh/templates/inputs"
	// metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ConfigMap: corev1.#ConfigMap & {
	_config: i.#Config

	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: _config.metadata
	immutable: _config.configmap.immutable
	data: _config.configmap.data
}
