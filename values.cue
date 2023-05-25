package main

values: {
	// Placeholder for user-supplied values
	// service: type: "NodePort"
	service: ports: [{port: 8081}, {port: 8888, targetPort: 9090}]
}
