package main

import "github.com/xunholy/cue-template/templates"

values: {
	controller: templates.#DeploymentConfig

	// Placeholder for user-supplied values
	// service: type: "NodePort"
	service: ports: [{port: 8081}, {port: 8888, targetPort: 9090}]
}
