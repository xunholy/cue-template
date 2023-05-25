package templates

import (
	corev1 "k8s.io/api/core/v1"
)

#PodTemplateSpec: corev1.#Pod & {
	_config: #Config

	spec: {
		imagePullSecrets?: _config.pod.imagePullSecrets
		serviceAccountName: _config.pod.serviceAccountName
		automountServiceAccountToken: _config.pod.automountServiceAccountToken
		securityContext: _config.pod.podSecurityContext
		priorityClassName?: _config.pod.priorityClassName
		runtimeClassName?: _config.pod.runtimeClassName
		schedulerName?: _config.pod.schedulerName
		hostIPC: _config.pod.hostIPC
		hostNetwork: _config.pod.hostNetwork
		hostPID: _config.pod.hostPID
		hostname?: _config.pod.hostname
		dnsPolicy: _config.pod.dnsPolicy
		dnsConfig: _config.pod.dnsConfig
		enableServiceLinks: _config.pod.enableServiceLinks
		terminationGracePeriodSeconds?: _config.pod.terminationGracePeriodSeconds
		initContainers: _config.pod.initContainers
		containers: _config.pod.containers
		volumes: _config.pod.volumes
		hostAliases: _config.pod.hostAliases
		nodeSelector: _config.pod.nodeSelector
		affinity: _config.pod.affinity
		topologySpreadConstraints: _config.pod.topologySpreadConstraints
		tolerations: _config.pod.tolerations
		restartPolicy: _config.pod.restartPolicy
	}
}
