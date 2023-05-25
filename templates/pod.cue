package templates

import "k8s.io/api/core/v1"

#PodTemplate: {
	config:   #Config
	template: v1.#PodTemplateSpec & {
		metadata: {
			labels: config.controller.labels
			// annotations: config.metadata.annotations
		}
		spec: {
			// imagePullSecrets?:              config.pod.imagePullSecrets
			// serviceAccountName:             config.pod.serviceAccountName
			// automountServiceAccountToken:   config.pod.automountServiceAccountToken
			// securityContext:                config.pod.podSecurityContext
			// priorityClassName?:             config.pod.priorityClassName
			// runtimeClassName?:              config.pod.runtimeClassName
			// schedulerName?:                 config.pod.schedulerName
			// hostIPC:                        config.pod.hostIPC
			// hostNetwork:                    config.pod.hostNetwork
			// hostPID:                        config.pod.hostPID
			// hostname?:                      config.pod.hostname
			// dnsPolicy:                      config.pod.dnsPolicy
			// dnsConfig:                      config.pod.dnsConfig
			// enableServiceLinks:             config.pod.enableServiceLinks
			// terminationGracePeriodSeconds?: config.pod.terminationGracePeriodSeconds
			// initContainers:                 config.pod.initContainers
			// containers:                     config.pod.containers
			// volumes:                        config.pod.volumes
			// hostAliases:                    config.pod.hostAliases
			// nodeSelector:                   config.pod.nodeSelector
			// affinity:                       config.pod.affinity
			// topologySpreadConstraints:      config.pod.topologySpreadConstraints
			// tolerations:                    config.pod.tolerations
			// restartPolicy:                  config.pod.restartPolicy
		}
	}
}
