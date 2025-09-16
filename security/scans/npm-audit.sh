#!/usr/bin/env bash
set -euo pipefail

echo "Running npm audit..."
npm audit --json > audit.json || true

HIGH_COUNT=$(jq '[.advisories[]? | select(.severity=="high" or .severity=="critical")] | length' audit.json)
if [ "$HIGH_COUNT" -gt 0 ]; then
  echo "Found $HIGH_COUNT high/critical vulnerabilities"
  jq '.advisories' audit.json
  exit 1
fi

echo "No high/critical vulnerabilities found."
