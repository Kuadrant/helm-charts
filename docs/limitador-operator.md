# Kuadrant Helm Charts Repository
Kuadrant repository for its Helm Charts

## Setup Repo Info

```shell
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
```

See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation.

## Limitador operator chart
This is the Helm Chart to install the official Limitador Kubernetes Operator

### Installation

```sh
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
helm install \
 limitador-operator kuadrant/limitador-operator \
 --create-namespace \
 --namespace limitador-system
```

## Parameters
**Coming soon!** At the moment, there's no configuration parameters exposed.

## Usage
Read the documentation and user guides in the [Getting Started guide](https://github.com/Kuadrant/dns-operator/?tab=readme-ov-file#getting-started).

## Other Charts

| Chart              | Reference                                                    | Docs                             |
|--------------------|--------------------------------------------------------------|----------------------------------|
| Kuadrant operator  | `helm install kuadrant-operator kuadrant/kuadrant-operator`  | [install](../README.md)          |
| Authorino operator | `helm install kuadrant-operator kuadrant/authorino-operator` | [install](authorino-operator.md) |
| DNS Operator       | `helm install kuadrant-operator kuadrant/dns-operator`       | [install](dns-operator.md)       |
