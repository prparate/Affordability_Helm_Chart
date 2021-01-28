#!/bin/bash

help () {
      echo "usage <proj> backend|frontend pull|export|save|push"
      exit 1
}

if [ -z "$1" ]
then
    help
fi

if [ -z "$2" ]
then
    help
fi

if [ -z "$3" ]
then
    help
fi

HELM="helm"
pull() {
    HELM_EXPERIMENTAL_OCI=1 helm chart pull $REPO_TAG
}

export() {
    HELM_EXPERIMENTAL_OCI=1 helm chart export $REPO_TAG
}

save() {
    HELM_EXPERIMENTAL_OCI=1 helm chart save . $REPO_TAG
}

push() {
    HELM_EXPERIMENTAL_OCI=1 ${HELM} chart push $REPO_TAG
}
# export HELM_EXPERIMENTAL_OCI=1

REGISTRY="premfinaukcontainerregistry.azurecr.io/helm"
PROJ=$1
REPO_FEBE=$2
CMD=$3
TAG="1.0.0"

REPO="${REGISTRY}/${REPO_FEBE}/${PROJ}"
REPO_TAG="${REPO}:${TAG}"

echo "CMD:$CMD TARGET: $REPO_TAG " 

if [ $CMD = "save" ]
then
    save
fi

if [ $CMD = "push" ]
then
    push
fi

if [ $CMD = "pull" ]
then
    pull
fi

if [ $CMD = "export" ]
then
    export
fi

# helm chart pull premfinaukcontainerregistry.azurecr.io/helm/$FEBE/$PROJ:1.0.0
# helm chart export premfinaukcontainerregistry.azurecr.io/helm/$FEBE/$PROJ:1.0.0
# helm chart save . premfinaukcontainerregistry.azurecr.io/helm/$FEBE/$PROJ:1.0.0


# helm chart push premfinaukcontainerregistry.azurecr.io/helm/$FEBE/$PROJ:1.0.0


