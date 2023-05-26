# CUE Kubernetes Templates

This repository contains CUE templates for defining Kubernetes resources, designed specifically to integrate with FluxCD for GitOps-based deployments. The templates simplify the process of creating and managing Kubernetes objects, reducing errors, and enhancing reusability. These templates, along with FluxCD, empower you to automate your Kubernetes deployments securely and efficiently, providing an easier path towards immutable infrastructure.

You'll find templates for various Kubernetes resources including Deployments, Services, ConfigMaps, and more. Each template is designed with customization and ease of use in mind, to fit different use-cases. Whether you're managing a small project or orchestrating a large microservices architecture, this repository will be your stepping stone towards better configuration management in Kubernetes.

This repository also includes documentation and examples to get you started with using CUE and FluxCD in your Kubernetes environment.

## Why use CUE?

[CUE](https://cuelang.org/) combines the benefits of schema and value-level validation, and allows you to define the structure of your data and its constraints in one place. It provides a unified way to handle configuration, ensuring less redundancy, and a more robust, error-free setup. With CUE, you can focus more on the logic of your application, rather than getting stuck in the complexities of configuration.

For more details on the core issues addressed by CUE, and how it can benefit your configuration management process, follow this link: [Core issues addressed by CUE](https://cuelang.org/docs/usecases/configuration/#core-issues-addressed-by-cue)

## Usage

### Format

```sh
❯ cue fmt -s ./...
```

### Build

```sh
❯ go run github.com/stefanprodan/timoni/cmd/timoni build some-release-name .
```

### Lint

```sh
❯ go run github.com/stefanprodan/timoni/cmd/timoni mod lint .
```
