#!/usr/bin/env bash
set -euo pipefail
CHECK_DIR=${1:-.}
tmp=$(mktemp)
checkov -d "$CHECK_DIR" -o json > "$tmp" || true
HIGH=$(jq '.results[] | select(.check_result.severity=="HIGH")' "$tmp" | wc -l || true)
CRIT=$(jq '.results[] | select(.check_result.severity=="CRITICAL")' "$tmp" | wc -l || true)
echo "checkov found HIGH=$HIGH CRITICAL=$CRIT"
if [ "$CRIT" -gt 0 ] || [ "$HIGH" -gt 0 ]; then
  jq '.' "$tmp"
  exit 1
fi
echo "checkov OK"
