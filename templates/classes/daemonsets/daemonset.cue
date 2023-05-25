package daemonsets

import (
	appsv1 "k8s.io/api/apps/v1"
	// corev1 "k8s.io/api/core/v1"
	p "timoni.sh/templates/controllers/pods"
	i "timoni.sh/templates/inputs"
	// metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DaemonSet : appsv1.#DaemonSet  & {
	_config: i.#Config

	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: _config.metadata

	// https://pkg.go.dev/k8s.io/api/apps/v1#DaemonSetSpec
	spec: appsv1.#DaemonSetSpec & {
		selector: matchLabels: _config.metadata.labels
		template: {
			metadata: {
				annotations: _config.metadata.annotations
				labels: _config.deployment.podLabels
			}
			p.#PodTemplateSpec
		}
	}
}
