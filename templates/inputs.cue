package templates

import (
	"strings"

	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
	metadata:  #MetadataConfig
	pod:       #PodConfig
	configmap: #ConfigMapConfig
	service:   #ServiceConfig
	ingress:   #IngressConfig

	// Setting the default controller type to use deployments else use statefulset
	controller: #ControllerConfig
}

#ControllerConfig: {
	enabled: *true | bool
	type:    *"deployment" | "statefulset" | "daemonset"
	annotations: [string]: string
	labels: [string]: string
	replicas:      *1 | int
	restartPolicy: *"Always" | corev1.#RestartPolicy
	// TODO: Should set strategy type options here or simplify this and rely on type validation
	// EG.
	// strategy: *"RollingUpdate" | "Recreate" | "OnDelete"
	if type == "deployment" {
		strategy: *"RollingUpdate" | "Recreate"
	}
	if type == "statefulset" {
		strategy: *"RollingUpdate" | "OnDelete"
	}
}

#IngressConfig: {
	ingressClassName: *null | string
	enabled:          *true | bool
}

#ConfigMapConfig: {
	immutable: *false | bool
	data: {...}
}

#ServiceConfig: {
	// TODO: How does this get overriden
	ports: [...#Port]
	// selector: [...]
	// clusterIP: string
	// clusterIPs: [...]
	type: *"ClusterIP" | "NodePort" | "LoadBalancer" | "ExternalName"
	// externalIPs: [...]
	sessionAffinity: *"None" | "ClientIP"
	// loadBalancerIP: [...]
	// loadBalancerSourceRanges: [...]
	// externalName: [...]
	// externalTrafficPolicy: [...]
	// ipFamilies: [...]
	// ipFamilyPolicy: [...]
	// allocateLoadBalancerNodePorts: [...]
	// loadBalancerClass: [...]
	// internalTrafficPolicy:[...]
}

#Port: {
	port:       *80 | int & >0 & <=65535
	targetPort: *port | int & >0 & <=65535
	name:       *"main" | string
	protocol:   *"TCP" | "UDP" | "SCTP"
}

#MetadataConfig: metav1.#ObjectMeta & {
	name:        *"example" | string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)
	namespace:   *"default" | string & strings.MaxRunes(63)
	labels:      *null | {[string]: string}
	annotations: *null | {[string]: string}
}

#PodConfig: {
	imagePullSecrets?: [...]
	serviceAccountName:             *"default" | string
	automountServiceAccountToken:   *true | bool
	podSecurityContext:             corev1.#PodSecurityContext
	priorityClassName?:             string
	runtimeClassName?:              string
	schedulerName?:                 string
	hostIPC:                        *false | bool
	hostNetwork:                    *false | bool
	hostPID:                        *false | bool
	hostname?:                      string
	dnsPolicy:                      *"ClusterFirst" | string
	dnsConfig:                      corev1.#PodDNSConfig
	enableServiceLinks:             *true | bool
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
