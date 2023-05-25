package templates

import "strings"

#Instance: {
	config: #Config

	let _templates = [#ConfigMapTemplate, #DaemonSetTemplate, #DeploymentTemplate, #IngressTemplate, #ServiceTemplate, #StatefulSetTemplate]

	objects: {
		for template in _templates {
			// https://github.com/cue-lang/cue/issues/2420
			let _config = config

			let object = template & {config: _config}

			if object.template != _|_ {
				let name = object.template.metadata.name
				let kind = strings.ToLower(object.template.kind)
				"\(name)-\(kind)": object.template
			}
		}
	}
}
