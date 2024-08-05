# Kuadrant Helm Charts Repository
Kuadrant repository for its Helm Charts

## Setup Repo Info

```shell
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
```

See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation.

## Installing a Chart

Installing a Kuadrant Chart, i.e: `limitador-operator`
```shell
helm install limitador-operator kuadrant/limitador-operator
```

This will install the latest released stable version of the Limitador Operator in its default namespace `limitador-operator-system`, if it's needed to install a pre release version (for example `limitador-operator-0.10.0-alpha3.tgz`, one need to pass the `--devel` flag.

### Installing charts with dependencies

Some of the Kuadrant charts, Authorino Operator or Kuadrant Operator for example, require some extra dependencies that need to be present in the cluster prior the installation. These are the following:

* [Gateway API](https://gateway-api.sigs.k8s.io)
* A Gateway Provider, for example, [Istio](https://istio.io/latest/docs/setup/install/helm/)
* [Cert Manager](https://cert-manager.io/docs/installation/helm/)
