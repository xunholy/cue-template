package templates

import (
	"strings"

	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
	// networkingv1 "k8s.io/api/networking/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
	controller: #DaemonSetConfig | *#DeploymentConfig | #StatefulSetConfig
	metadata:   #MetadataConfig
	pod:        #PodConfig
	configmap:  #ConfigMapConfig
	service:    #ServiceConfig
	ingress:    #IngressConfig
}

_#ControllerConfig: {
	enabled:       bool | *true
	annotations:   ({[string]: string}) | *null
	labels:        ({[string]: string}) | *null
	restartPolicy: v1.#RestartPolicy | *v1.#RestartPolicyAlways
}

#DaemonSetConfig: {
	_#ControllerConfig

	// https://github.com/cue-lang/cue/issues/2421
	daemonset: true

	strategy: appsv1.#DaemonSetUpdateStrategy | *appsv1.#RollingUpdateDaemonSetStrategyType
}

#DeploymentConfig: {
	_#ControllerConfig

	// https://github.com/cue-lang/cue/issues/2421
	deployment: true

	replicas: int | *1
	strategy: appsv1.#DeploymentStrategy | *appsv1.#RollingUpdateDeploymentStrategyType
	if strategy == appsv1.#RollingUpdateDeploymentStrategyType {
		rollingUpdate: appsv1.#RollingUpdateDeployment | *null
	}
}

#StatefulSetConfig: {
	_#ControllerConfig

	// https://github.com/cue-lang/cue/issues/2421
	statefulset: true

	replicas: int | *1
	strategy: appsv1.#StatefulSetUpdateStrategy | *appsv1.#RollingUpdateStatefulSetStrategyType
	if strategy == appsv1.#RollingUpdateDeploymentStrategyType {
		rollingUpdate: appsv1.#RollingUpdateStatefulSetStrategy | *null
	}
}

#IngressConfig: {
	enabled:          bool | *true
	ingressClassName: string | *null
}

#ConfigMapConfig: {
	immutable: bool | *false
	data:      ({[string]: string}) | *null
}

#ServiceConfig: {
	// TODO: How does this get overridden
	ports: [...v1.#ServicePort] | *null
	// selector: [...]
	// clusterIP: string
	// clusterIPs: [...]
	type: v1.#ServiceType | *v1.#ServiceTypeClusterIP
	// externalIPs: [...]
	sessionAffinity: v1.#ServiceAffinity | *v1.#ServiceAffinityNone
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

#MetadataConfig: metav1.#ObjectMeta & {
	name:      *"example" | string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)
	namespace: *"default" | string & strings.MaxRunes(63)
}

#PodConfig: {
	imagePullSecrets?: [...]
	serviceAccountName?:            *"default" | string
	automountServiceAccountToken?:  *true | bool
	podSecurityContext?:            v1.#PodSecurityContext
	priorityClassName?:             string
	runtimeClassName?:              string
	schedulerName?:                 string
	hostIPC?:                       *false | bool
	hostNetwork?:                   *false | bool
	hostPID?:                       *false | bool
	hostname?:                      string
	dnsPolicy?:                     string | *v1.#DNSClusterFirst
	dnsConfig?:                     v1.#PodDNSConfig
	enableServiceLinks?:            *true | bool
	terminationGracePeriodSeconds?: int & >0
	initContainers?: [...]
	containers?: [...]
	volumes?: [...]
	hostAliases?: [...]
	nodeSelector?: {...}
	affinity?: v1.#Affinity
	topologySpreadConstraints?: [...]
	tolerations:    [...v1.#Toleration] | *null
	restartPolicy?: *"Always" | v1.#RestartPolicy
}
