package templates

import (
	"strings"

	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
	// networkingv1 "k8s.io/api/networking/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ControllerKind: #DaemonSetController | #DeploymentController | #StatefulSetController

#DaemonSetController:   "daemonset"
#DeploymentController:  "deployment"
#StatefulSetController: "statefulset"

// Config defines the schema and defaults for the Instance values.
#Config: {
	controller: {
		#DeploymentConfig | #DaemonSetConfig | #StatefulSetConfig
		kind: *#DeploymentController | #ControllerKind
	}
	global:    #GlobalConfig
	metadata:  #MetadataConfig
	pod:       #PodConfig
	configmap: #ConfigMapConfig
	service:   #ServiceConfig
	ingress: [string]: #IngressConfig
	image: #ImageConfig

	nodeSelector: ({[string]: string})
}

#ImageConfig: {
	repository: *"" | string
	tag:        *"" | string
	pullPolicy: *v1.#PullIfNotPresent | v1.#PullPolicy
}

_#ControllerConfig: {
	_#Common
	enabled:       *true | bool
	restartPolicy: *v1.#RestartPolicyAlways | v1.#RestartPolicy
}

#DaemonSetConfig: {
	_#ControllerConfig
	kind: #DaemonSetController

	strategy: *appsv1.#RollingUpdateDaemonSetStrategyType | appsv1.#DaemonSetUpdateStrategy
}

#DeploymentConfig: {
	_#ControllerConfig
	kind: #DeploymentController

	replicas: *1 | int
	strategy: *appsv1.#RollingUpdateDeploymentStrategyType | appsv1.#DeploymentStrategy
	if strategy == appsv1.#RollingUpdateDeploymentStrategyType {
		rollingUpdate: *null | appsv1.#RollingUpdateDeployment
	}
}

#StatefulSetConfig: {
	_#ControllerConfig
	kind: #StatefulSetController

	replicas: *1 | int
	strategy: *appsv1.#RollingUpdateStatefulSetStrategyType | appsv1.#StatefulSetUpdateStrategy
	if strategy == appsv1.#RollingUpdateDeploymentStrategyType {
		rollingUpdate: *null | appsv1.#RollingUpdateStatefulSetStrategy
	}
}

#IngressConfig: {
	enabled: *true | bool
	_#Common
	ingressClassName: *null | string
}

#ConfigMapConfig: {
	_#Common
	immutable: *false | bool
	data:      *null | ({[string]: string})
}

#ServiceConfig: [#Name=string]: {
	_#Common
	ports:           *null | [...v1.#ServicePort]
	type:            *v1.#ServiceTypeClusterIP | v1.#ServiceType
	sessionAffinity: *v1.#ServiceAffinityNone | v1.#ServiceAffinity
	externalIPs:     *null | [...string]
}

#MetadataConfig: metav1.#ObjectMeta & {
	name:      *"example" | string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)
	namespace: *"default" | string & strings.MaxRunes(63)
}

#PodConfig: v1.#PodSpec

#GlobalConfig: _#Common

_#Common: {
	labels:      *null | ({[string]: string})
	annotations: *null | ({[string]: string})
}
