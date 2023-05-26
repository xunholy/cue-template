//go:build tools
// +build tools

package tools

import (
	_ "cuelang.org/go/cmd/cue"
	_ "github.com/stefanprodan/timoni/cmd/timoni"
	_ "k8s.io/api"
)
