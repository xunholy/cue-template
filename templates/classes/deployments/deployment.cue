package deployments

import (
	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#Deployment: appsv1.#Deployment & {
	_config:    #Config
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: metav1.#ObjectMeta & {
		name: _config.metadata.name
		namespace: _config.metadata.namespace
		labels: _config.metadata.labels
	}
	// https://pkg.go.dev/k8s.io/api/apps/v1#DeploymentSpec
	spec: appsv1.#DeploymentSpec & {
		replicas: 1
		selector: metav1.#LabelSelector
		template: corev1.#PodTemplateSpec & {
			metadata: metav1.#ObjectMeta
			spec: corev1.#PodSpec
		}
	}
}

#Instance: {
	config: #Config

	objects: {
		"\(config.metadata.name)-deploy": #Deployment & {_config: config}
	}
}
