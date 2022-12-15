#!/bin/bash

VERSION=${VERSION:-"v1.6.1"}

######
##  Clone Upstream

git clone --depth 1 --branch "$VERSION" git@github.com:kubeflow/manifests.git


######
## Copy manifests

# -
kustomize build common/cert-manager/cert-manager/base > helm/kubeflow-app/templates/cert-manager/resources.yaml
kustomize build common/cert-manager/kubeflow-issuer/base  > helm/kubeflow-app/templates/cert-manager-kubeflow-issuer/resources.yaml

# - kubeflow-namespace
kustomize build manifests/common/kubeflow-namespace/base > helm/kubeflow-app/templates/kubeflow-namespace/resources.yaml

# - kubeflow-roles
kustomize build manifests/common/kubeflow-roles/base > helm/kubeflow-app/templates/kubeflow-roles/resources.yaml

# - katib
kustomize build manifests/apps/katib/upstream/installs/katib-with-kubeflow > helm/kubeflow-app/templates/katib/resources.yaml

# - centraldashboard
kustomize build manifests/apps/centraldashboard/upstream/overlays/kserve > helm/kubeflow-app/templates/centraldashboard/resources.yaml

# - admission-webhook
kustomize build manifests/apps/admission-webhook/upstream/overlays/cert-manager > helm/kubeflow-app/templates/admission-webhook/resources.yaml

# - notebook-controller
kustomize build manifests/apps/jupyter/notebook-controller/upstream/overlays/kubeflow > helm/kubeflow-app/templates/notebook-controller/resources.yaml

# - jupyter-web-app
kustomize build manifests/apps/jupyter/jupyter-web-app/upstream/overlays/istio > helm/kubeflow-app/templates/jupyter-web-app/resources.yaml

# - profiles
kustomize build manifests/apps/profiles/upstream/overlays/kubeflow > helm/kubeflow-app/templates/profiles/resources.yaml

# - tensorboards-web-app
kustomize build manifests/apps/tensorboard/tensorboards-web-app/upstream/overlays/istio > helm/kubeflow-app/templates/tensorboards-web-app/resources.yaml

# - tensorboard-controller
kustomize build manifests/apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow > helm/kubeflow-app/templates/tensorboard-controller/resources.yaml

# - training-operator
kustomize build manifests/apps/training-operator/upstream/overlays/kubeflow > helm/kubeflow-app/templates/training-operator/resources.yaml

# - user-namespace
kustomize build manifests/common/user-namespace/base > helm/kubeflow-app/templates/user-namespace/resources.yaml

