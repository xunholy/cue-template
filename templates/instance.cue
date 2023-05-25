package templates

#Instance: {
	config: #Config

	objects: {
    if config.controller == "deployment" {
			"\(config.metadata.name)-deployment": #Deployment & {_config: config}
		}
    if config.controller == "daemonset" {
      "\(config.metadata.name)-daemonset": #DaemonSet & {_config: config}
    }
    if config.controller == "statefulset" {
      "\(config.metadata.name)-statefulset": #StatefulSet & {_config: config}
    }
		"\(config.metadata.name)-configmap": #ConfigMap & {_config: config}
    "\(config.metadata.name)-service": #Service & {_config: config}
    if config.ingress.enabled {
      "\(config.metadata.name)-ingress": #Ingress & {_config: config}
    }
	}
}
