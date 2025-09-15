#!/bin/bash
set -e

echo "⚙️  Setting up local environment with Minikube..."

minikube start --cpus=2 --memory=4g --driver=docker

echo "📦 Creating dev namespace..."
kubectl create ns dev --dry-run=client -o yaml | kubectl apply -f -

echo "🔑 Creating local DB secret..."
kubectl -n dev create secret generic db-secret \
  --from-literal=POSTGRES_USER=chatuser \
  --from-literal=POSTGRES_PASSWORD=chatpass \
  --from-literal=POSTGRES_DB=chatdb \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Local setup completed."