package templates

import (
	"strings"

  corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
  metadata: #MetadataConfig
  deployment: #DeploymentConfig
	statefulset: #StatefulSetConfig
	daemonset: #DaemonSetConfig
  pod: #PodConfig
	configmap: #ConfigMapConfig
	service: #ServiceConfig
	ingress: #IngressConfig

	// Setting the default controller type to use deployments else use statefulset
	controller: *"deployment" | "statefulset" | "daemonset"
}

#IngressConfig: {
	ingressClassName: *null | string
	enabled: *true | bool

}

#ConfigMapConfig: {
	immutable: *false | bool
	data: {...}
}

#StatefulSetConfig: {
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

#DaemonSetConfig: {
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
	port: *80        | int & >0 & <=65535
	targetPort: *port | int & >0 & <=65535
	name: *"main"    | string
	protocol: *"TCP" | "UDP" | "SCTP"
}

#MetadataConfig: metav1.#ObjectMeta & {
    name:      *"example" | string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)
    namespace: *"default" | string & strings.MaxRunes(63)
		labels: *null | {[string]: string}
		annotations: *null | {[string]: string}
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

#Instance: {
	config: #Config

	objects: {
    // if config.controller == "deployment" {
		// 	"\(config.metadata.name)-deployment": deployments.#Deployment & {_config: config}
		// }
    // if config.controller == "daemonset" {
    //   "\(config.metadata.name)-daemonset": daemonsets.#DaemonSet & {_config: config}
    // }
    // if config.controller == "statefulset" {
    //   "\(config.metadata.name)-statefulset": statefulsets.#StatefulSet & {_config: config}
    // }
		"\(config.metadata.name)-configmap": #ConfigMap & {_config: config}
    // "\(config.metadata.name)-service": services.#Service & {_config: config}
    // if config.ingress.enabled {
    //   "\(config.metadata.name)-ingress": ingresses.#Ingress & {_config: config}
    // }

	}
}
