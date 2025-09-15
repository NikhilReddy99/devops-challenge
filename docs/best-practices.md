# Best Practices

## Security
- Run containers as **non-root**.
- Enable **read-only root filesystem**.
- Store secrets in **Kubernetes Secrets / Jenkins Credentials**, never Git.
- Enable **RBAC** and least-privilege roles.

## CI/CD
- Scan Terraform with **tfsec** / **checkov**.
- Scan Docker images with **Trivy**.
- Enforce manual approval gates for **production**.

## Monitoring
- Use Prometheus & Grafana for metrics.
- Enable alerting for pod failures, resource exhaustion.