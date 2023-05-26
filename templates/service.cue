package templates

import corev1 "k8s.io/api/core/v1"

#ServiceTemplate: {
	config:   #Config
	template: corev1.#Service & {
		apiVersion: "v1"
		kind:       "Service"
		metadata:   config.metadata
		spec: {
			ports: config.service.ports
			// selector: matchLabels: config.metadata.labels
			// clusterIP: config.service.clusterIP
			// clusterIPs: config.service.clusterIPs
			type:            config.service.type
			externalIPs:     config.service.externalIPs
			sessionAffinity: config.service.sessionAffinity
			// loadBalancerIP: config.service
			// loadBalancerSourceRanges: config.service
			// externalName: config.service
			// externalTrafficPolicy: config.service
			// ipFamilies: config.service
			// ipFamilyPolicy: config.service
			// allocateLoadBalancerNodePorts: config.service
			// loadBalancerClass: config.service
			// internalTrafficPolicy:config.service
		}
	}
}
