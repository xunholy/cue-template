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
			for item in object.items {
				let name = item.metadata.name
				let kind = strings.ToLower(item.kind)
				"\(name)-\(kind)": item
			}
		}
	}
}
