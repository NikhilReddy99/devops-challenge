# Terraform - Local Minikube + Kubernetes modules

This folder contains Terraform modules and environment configs to:
- Start Minikube locally (via null_resource / local-exec)
- Provision Kubernetes namespace + example resources via the Kubernetes provider

Structure:
- modules/minikube: starts/stops Minikube using local-exec (PowerShell on Windows or bash on *nix)
- modules/k8s: creates namespaces and example resources (deployment + service)
- environments/*: environment-specific top-level configurations (dev/staging/prod)

Important:
- This is intended for local developer use (Docker Desktop + Minikube).
- Use `tfsec` to scan before apply: `tfsec ./environments/local/dev`
