package main

values: {
	controller: {
		kind: "statefulset"
		annotations: "reloader.stakater.com/auto": "true"
	}
	image: {
		repository: "ghcr.io/onedr0p/jellyfin"
		tag:        "10.8.10@sha256:1ef614db6a4c589777eb48bc9004d573b9c09f0d6d573a509041c6060f3a956b"
	}

	// env: {
	//     TZ: "America/New_York"
	// }
	// // envFrom: {
	// //     [
	// //         secretRef: name: "jellyfin-secret"
	// //     ]
	// // }
	ingress: main: {
		ingressClassName: "nginx"
		annotations: "hajimari.io/icon": "simple-icons:jellyfin"
	}
	global: annotations: "hajimari.io/icon2": "simple-icons:jellyfin2"
	service: main: {
		externalIPs: [
			"192.168.69.100",
		]
		ports: [
			{
				port:       8081
				targetPort: 8081
				name:       "main"
				protocol:   "TCP"
			},
		]
		type: "LoadBalancer"
	}
	nodeSelector: {
		"node-role.kubernetes.io/worker":       "true"
		"intel.feature.node.kubernetes.io/gpu": "true"
	}
	// volumeClaimTemplates: {
	//     [
	//         {
	//             name: "config"
	//             mountPath: "/config"
	//             accessMode: "ReadWriteOnce"
	//             size: "50Gi"
	//             storageClass: "ceph-block"
	//         }
	//     ]
	// }
	// persistence: {
	//     media: {
	//         type: "nfs"
	//         server: "expanse.turbo.ac"
	//         path: "/eros/Media"
	//         mountPath: "/media"
	//     }
	// }
	// resources: {
	//     requests: {
	//         "gpu.intel.com/i915": 1
	//         cpu: "100m"
	//         memory: 1000Mi
	//     }
	//     limits: {
	//         "gpu.intel.com/i915": 1
	//         memory: 4000Mi
	//     }
	// }
}
