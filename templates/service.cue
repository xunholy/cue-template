package templates

import corev1 "k8s.io/api/core/v1"

#ServiceListTemplate: {
	config: #Config
	items: [...corev1.#Service & {
		apiVersion: "v1"
		kind:       "Service"
	}]
	items: [ for serviceName, serviceConfig in config.service {
		metadata: {
			config.metadata
			labels: config.global.labels
			labels: "app.kubernetes.io/service": serviceName
			annotations: config.global.annotations
		}
		spec: {
			ports: serviceConfig.ports
			// selector: matchLabels: config.metadata.labels
			// clusterIP: serviceConfig.clusterIP
			// clusterIPs: serviceConfig.clusterIPs
			type:            serviceConfig.type
			externalIPs:     serviceConfig.externalIPs
			sessionAffinity: serviceConfig.sessionAffinity
			// loadBalancerIP: serviceConfig
			// loadBalancerSourceRanges: serviceConfig
			// externalName: serviceConfig
			// externalTrafficPolicy: serviceConfig
			// ipFamilies: serviceConfig
			// ipFamilyPolicy: serviceConfig
			// allocateLoadBalancerNodePorts: serviceConfig
			// loadBalancerClass: serviceConfig
			// internalTrafficPolicy:serviceConfig
		}
	}]
}
