# Architecture Diagram

The architecture diagram (editable Draw.io format) is located at:

`docs/images/devops-architecture.drawio`

Open it with draw.io (https://app.diagrams.net/)

# Architecture Overview

Local-first architecture:
- Developer machine runs Docker Desktop.
- Minikube uses Docker driver (single-node k8s).
- Docker registry at nikhilreddy99 dockerhub for images.
- Jenkins runs in Docker for CI/CD.
- Terraform used to start Minikube (local-exec) and manage k8s resources via kubernetes provider.
- Sample microservices:
  - chat-service (Spring Boot, WebSocket)
  - user-service (Spring Boot, REST + JPA)
  - messages-service (Spring Boot, REST + JPA)
  - frontend (React)

Environment separation:
- Namespaces: dev, staging, production.
- Images tagged per environment.

Security considerations:
- tfsec integrated as a pre-apply check.
- Trivy integrated to scan built images in pipeline.
- Secrets stored as Kubernetes Secrets; do not commit secrets.

