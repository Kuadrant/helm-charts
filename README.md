# Kuadrant Helm Charts Repository
Kuadrant repository for its Helm Charts

## Setup Repo Info

```shell
helm repo add kuadrant https://kuadrant.io/helm-charts/
helm repo update
```

See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation.

## Installing a Chart

Installing a Kuadrant Chart, i.e: `limitador-operator`
```shell
kubectl create namespace kuadrant-system
helm install limitador-operator kuadrant/limitador-operator --namespace kuadrant-system
```
