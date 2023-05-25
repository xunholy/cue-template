package instances

import (
	i "timoni.sh/templates/inputs"
  configmaps "timoni.sh/templates/classes/configmaps"
  deployments "timoni.sh/templates/classes/deployments"
  daemonsets "timoni.sh/templates/classes/daemonsets"
  statefulsets "timoni.sh/templates/classes/daemonsets"
  services "timoni.sh/templates/classes/services"
  ingresses "timoni.sh/templates/classes/ingresses"
)

#Instance: {
	config: i.#Config

	objects: {
    if config.controller == "deployment" {
			"\(config.metadata.name)-deployment": deployments.#Deployment & {_config: config}
		}
    if config.controller == "daemonset" {
      "\(config.metadata.name)-daemonset": daemonsets.#DaemonSet & {_config: config}
    }
    if config.controller == "statefulset" {
      "\(config.metadata.name)-statefulset": statefulsets.#StatefulSet & {_config: config}
    }
		"\(config.metadata.name)-configmap": configmaps.#ConfigMap & {_config: config}
    "\(config.metadata.name)-service": services.#Service & {_config: config}
    if config.ingress.enabled {
      "\(config.metadata.name)-ingress": ingresses.#Ingress & {_config: config}
    }

	}
}
