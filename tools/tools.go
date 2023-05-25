//go:build tools
// +build tools

package tools

import (
	_ "cuelang.org/go/cmd/cue"
	_ "k8s.io/api"
)
