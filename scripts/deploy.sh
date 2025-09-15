#!/bin/bash
set -e

NAMESPACE=${1:-dev}
echo "🚀 Deploying to namespace: $NAMESPACE"

kubectl create ns $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -k kubernetes/kustomize/$NAMESPACE

echo "✅ Deployment successful."