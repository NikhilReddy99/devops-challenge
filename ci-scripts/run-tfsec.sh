#!/usr/bin/env bash
set -euo pipefail
TF_DIR=${1:-terraform}
tmp=$(mktemp)
tfsec --format json "$TF_DIR" > "$tmp" || true
HIGH=$(jq '.results[] | select(.severity=="HIGH")' "$tmp" | wc -l || true)
CRIT=$(jq '.results[] | select(.severity=="CRITICAL")' "$tmp" | wc -l || true)
echo "tfsec found HIGH=$HIGH CRITICAL=$CRIT"
if [ "$CRIT" -gt 0 ] || [ "$HIGH" -gt 0 ]; then
  jq '.' "$tmp"
  exit 1
fi
echo "tfsec OK"
