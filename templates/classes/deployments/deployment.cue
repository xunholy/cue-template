package deployments

import (
	appsv1 "k8s.io/api/apps/v1"
	// corev1 "k8s.io/api/core/v1"
	p "timoni.sh/templates/controllers/pods"
	i "timoni.sh/templates/inputs"
	// metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#Deployment: appsv1.#Deployment & {
	_config: i.#Config
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: _config.metadata
	// https://pkg.go.dev/k8s.io/api/apps/v1#DeploymentSpec
	spec: appsv1.#DeploymentSpec & {
		replicas: _config.deployment.controller.replicas
		strategy: {
			type: _config.deployment.controller.strategy
			rollingUpdate: _config.controller.rollingUpdate | {...}
		}
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

#Instance: {
	config: i.#Config

	objects: {
		"\(config.metadata.name)-deploy": #Deployment & {_config:     config}
	}
}
