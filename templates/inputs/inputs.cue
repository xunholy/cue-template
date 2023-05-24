package inputs

import (
  corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	// corev1 "k8s.io/api/core/v1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
  metadata: #MetadataConfig
  deployment: #DeploymentConfig
  pod: #PodConfig
}

#DeploymentConfig: {
  podLabels: {...}
  controller: {
    replicas: *1 | int
    strategy: "RollingUpdate"
    rollingUpdate?: {
      unavailable?: string
      surge?: string
    }
  }
}

#MetadataConfig: metav1.#ObjectMeta & {
    name:      *"EXAMPLE" | string
    namespace: *"default" | string
		labels: {...}
		annotations: {...}
}

#PodConfig: {
	imagePullSecrets?: [...]
	serviceAccountName: *"default" | string
	automountServiceAccountToken: *true | bool
	podSecurityContext: corev1.#PodSecurityContext
	priorityClassName?: string
	runtimeClassName?: string
	schedulerName?: string
	hostIPC: *false | bool
	hostNetwork: *false | bool
	hostPID: *false | bool
	hostname?: string
	dnsPolicy: *"ClusterFirst" | string
	dnsConfig: corev1.#PodDNSConfig
	enableServiceLinks: *true | bool
	terminationGracePeriodSeconds?: int & >0
	initContainers: [...]
	containers: [...]
	volumes: [...]
	hostAliases: [...]
	nodeSelector: {...}
	affinity: corev1.#Affinity
	topologySpreadConstraints: [...]
	tolerations: [...]
	restartPolicy: *"Always" | corev1.#RestartPolicy
}
