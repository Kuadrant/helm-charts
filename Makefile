# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_PATH := $(patsubst %/,%,$(dir $(MKFILE_PATH)))

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Helm

HELM = $(PROJECT_PATH)/bin/helm
HELM_VERSION = v3.15.0
$(HELM):
	@{ \
	set -e ;\
	mkdir -p $(dir $(HELM)) ;\
	OS=$(shell go env GOOS) && ARCH=$(shell go env GOARCH) && \
	wget -O helm.tar.gz https://get.helm.sh/helm-$(HELM_VERSION)-$${OS}-$${ARCH}.tar.gz ;\
	tar -zxvf helm.tar.gz ;\
	mv $${OS}-$${ARCH}/helm $(HELM) ;\
	chmod +x $(HELM) ;\
	rm -rf $${OS}-$${ARCH} helm.tar.gz ;\
	}

.PHONY: helm
helm: $(HELM) ## Download helm locally if necessary.

.PHONY: helm-index
helm-index: $(HELM) ## Update the helm repository index
	$(HELM) repo index charts

##@ Sync chart packages

# GitHub Release Asset Browser Download URL, it can be find in the output of the uploaded asse
BROWSER_DOWNLOAD_URL ?= <BROWSER-DOWNLOAD-URL>
# Dependency chart name, ie: limitador-operator
CHART_NAME ?= <CHART-NAME>
# Dependency chart semver, ie: 1.0.0
CHART_VERSION ?= <CHART-VERSION>

.PHONY: get-chart
get-chart: ## Get the chart package and prov file from its repository
	curl -L -o ./charts/$(CHART_NAME)-$(CHART_VERSION).tgz $(BROWSER_DOWNLOAD_URL)
	curl -L -o ./charts/$(CHART_NAME)-$(CHART_VERSION).tgz.prov $(BROWSER_DOWNLOAD_URL).prov

.PHONY: delete-chart
delete-chart: ## Delete the chart package and prov file from its repository
	rm -f ./charts/$(CHART_NAME)-$(CHART_VERSION).tgz*

# Organization
ORG ?= kuadrant
# GitHub Token with permissions to upload to the release assets
HELM_WORKFLOWS_TOKEN ?= <YOUR-TOKEN>
# Github repo name for the helm charts repository
HELM_REPO_NAME ?= helm-charts

.PHONY: trigger-release
helm-sync-package-created: ## Trigger the release GH workflow, usually when the chart index has been updated
	curl -L \
	  -X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer $(HELM_WORKFLOWS_TOKEN)" \
	  -H "X-GitHub-Api-Version: 2022-11-28" \
	  https://api.github.com/repos/$(ORG)/$(HELM_REPO_NAME)/dispatches \
	  -d '{"event_type":"trigger-release","client_payload":{}}'
