package templates

import "strings"

#Instance: {
	config: #Config

	let _templates = [#ConfigMapListTemplate, #DaemonSetListTemplate, #DeploymentListTemplate, #IngressListTemplate, #ServiceListTemplate, #StatefulSetListTemplate]

	objects: {
		for template in _templates {
			// https://github.com/cue-lang/cue/issues/2420
			let _config = config

			let object = template & {config: _config}

			if object.template != _|_ {
				for template in object.template {
					let name = template.metadata.name
					let kind = strings.ToLower(template.kind)
					"\(name)-\(kind)": template
				}
			}
		}
	}
}
