package templates

import (
	corev1 "k8s.io/api/core/v1"
)

#Service: corev1.#Service & {
	_config: #Config

	apiVersion: "v1"
	kind:       "Service"
	metadata: _config.metadata

	spec: {
		ports: _config.service.ports
		// selector: matchLabels: _config.metadata.labels
		// clusterIP: _config.service.clusterIP
		// clusterIPs: _config.service.clusterIPs
		type: _config.service.type
		// externalIPs: _config.service.externalIPs
		sessionAffinity: _config.service.sessionAffinity
		// loadBalancerIP: _config.service
		// loadBalancerSourceRanges: _config.service
		// externalName: _config.service
		// externalTrafficPolicy: _config.service
		// ipFamilies: _config.service
		// ipFamilyPolicy: _config.service
		// allocateLoadBalancerNodePorts: _config.service
		// loadBalancerClass: _config.service
		// internalTrafficPolicy:_config.service
	}
}
