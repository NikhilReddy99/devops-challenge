#!/bin/bash
set -e

NAMESPACE=${1:-dev}
echo "🧹 Cleaning up namespace: $NAMESPACE"

kubectl delete ns $NAMESPACE --ignore-not-found

echo "✅ Cleanup done."
