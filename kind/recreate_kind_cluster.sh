#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: No cluster name provided."
  echo "Usage: $0 <cluster_name>"
  exit 1
fi

CLUSTER_NAME=$1
KIND_CONFIG_FILE="${CLUSTER_NAME}/kind-${CLUSTER_NAME}-config.yaml"

if [ ! -f "$KIND_CONFIG_FILE" ]; then
  echo "Error: Config file not found: $KIND_CONFIG_FILE"
  exit 1
fi

# Check if the cluster exists
if kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
  read -p "Cluster '${CLUSTER_NAME}' already exists. Do you want to recreate it? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting."
    exit 1
  fi
  echo "Deleting existing KinD cluster named ${CLUSTER_NAME}..."
  kind delete cluster --name ${CLUSTER_NAME}
fi

echo "Creating new KinD cluster with ${KIND_CONFIG_FILE}..."
kind create cluster --config ${KIND_CONFIG_FILE} --name ${CLUSTER_NAME}

echo "Cluster recreation and kubeconfig update complete."


kubectx kind-${CLUSTER_NAME}

if [ "$CLUSTER_NAME" = "kind" ]; then
  kubectl config set-cluster kind-kind --server=https://192.168.1.78:6443 --kubeconfig ~/.kube/config
else
  # Source environment variables
  if [ -f "${CLUSTER_NAME}/.env" ]; then
    export $(cat "${CLUSTER_NAME}/.env" | xargs)
  fi
  curl https://downloads.portainer.io/ee2-31/portainer-edge-agent-setup.sh | bash -s -- "$PORTAINER_ENVIRONMENT_HASH" "$PORTAINER_EDGE_KEY" "1" "" ""
  rm portainer-agent-edge-k8s.yaml
fi