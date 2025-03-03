# Kuadrant Helm Charts Repository
Kuadrant repository for its Helm Charts

## Setup Repo Info

```shell
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
```

See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation.

## Authorino operator chart
This is the Helm Chart to install the official Authorino Kubernetes Operator

### Installation

```sh
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
helm install \
 authorino-operator kuadrant/authorino-operator \
 --create-namespace \
 --namespace authorino-system
```

## Parameters
**Coming soon!** At the moment, there's no configuration parameters exposed.

## Usage
Read the documentation and user guides in the [Getting Started guide](https://github.com/Kuadrant/dns-operator/?tab=readme-ov-file#getting-started).

## Other Charts

* [Kuadrant Operator](../README.md)
* [DNS Operator](dns-operator.md)
* [Limitador Operator](limitador-operator.md)
