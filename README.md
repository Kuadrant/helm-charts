# Kuadrant Helm Charts Repository
Kuadrant repository for its Helm Charts

## Setup Repo Info

```shell
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
```

See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation.

## Kuadrant operator chart
The official Kuadrant Kubernetes Operator

### Install Dependencies
Follow the steps below to install the following dependencies for Kuadrant Operator:
- [Gateway API](https://gateway-api.sigs.k8s.io/)
- [cert-manager](https://cert-manager.io/)
- A Gateway Provider [Istio](https://istio.io/latest/docs/ambient/install/helm/) or [Envoy Gateway](https://gateway.envoyproxy.io/)

#### Kubernetes Gateway API:

 ```sh
 kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml
 ```

#### cert-manager

 ```sh
 helm repo add jetstack https://charts.jetstack.io --force-update
 helm install \
   cert-manager jetstack/cert-manager \
   --namespace cert-manager \
   --create-namespace \
   --version v1.15.3 \
   --set crds.enabled=true
 ```

#### Gateway Provider (I.E. Istio):

 ```sh
 helm install sail-operator \
         --create-namespace \
         --namespace istio-system \
         --wait \
         --timeout=300s \
         https://github.com/istio-ecosystem/sail-operator/releases/download/0.1.0/sail-operator-0.1.0.tgz

 kubectl apply -f -<<EOF
 apiVersion: sailoperator.io/v1alpha1
 kind: Istio
 metadata:
   name: default
 spec:
   # Supported values for sail-operator v0.1.0 are [v1.22.4,v1.23.0]
   version: v1.23.0
   namespace: istio-system
   # Disable autoscaling to reduce dev resources
   values:
     pilot:
       autoscaleEnabled: false
 EOF
 ```

### Install Kuadrant Operator

```sh
helm repo add kuadrant https://kuadrant.io/helm-charts/ --force-update
helm install \
 kuadrant-operator kuadrant/kuadrant-operator \
 --create-namespace \
 --namespace kuadrant-system
```

### Parameters
**Coming soon!** At the moment, there's no configuration parameters exposed.

## Usage
Read the documentation and user guides in [Kuadrant.io](https://docs.kuadrant.io).

## Other Charts
You can also install individual Kuadrant components via helm charts if you prefer.

| Chart              | Reference                                                    | Docs                                  |
|--------------------|--------------------------------------------------------------|---------------------------------------|
| Limitador operator | `helm install kuadrant-operator kuadrant/limitador-operator` | [install](docs/limitador-operator.md) |
| Authorino operator | `helm install kuadrant-operator kuadrant/authorino-operator` | [install](docs/authorino-operator.md) |
| DNS Operator       | `helm install kuadrant-operator kuadrant/dns-operator`       | [install](docs/dns-operator.md)       |
