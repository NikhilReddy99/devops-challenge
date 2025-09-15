# Troubleshooting Guide

## Kubernetes
- **Pods stuck in CrashLoopBackOff**  
  → Run `kubectl describe pod <pod>` and `kubectl logs <pod>`

- **Service not reachable**  
  → Check Service type (ClusterIP, NodePort, LoadBalancer) and correct port mapping.

## Jenkins
- **Pipeline fails at image push**  
  → Verify Docker credentials and registry login.

- **Secrets not injected**  
  → Ensure Jenkins Credentials Store contains correct `db-creds` ID.

## Terraform
- **Plan fails**  
  → Run `terraform init -upgrade` to refresh providers.
