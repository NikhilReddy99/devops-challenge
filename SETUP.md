# Setup Instructions (Local)

Prereqs:
- Docker Desktop (with Kubernetes available)
- Minikube (if used standalone)
- Terraform >= 1.4
- Java 17 & Maven (for local builds) - optional if using Docker multi-stage builds
- Node.js & npm (for frontend build) - optional
- Jenkins (optional, recommended to run in Docker)
- tfsec and trivy (for security scans)

Quickstart (dev):
1. Start Docker Desktop and ensure it has enough memory (>= 6GB recommended).
2. Start local registry:
   ```
   docker run -d -p 5000:5000 --name registry registry:2
   ```
3. Run Terraform to start Minikube (this module uses local-exec):
   ```
   cd terraform/environments/dev
   terraform init
   terraform apply -auto-approve
   ```
4. Build and push the sample images (docker-compose will build as well):
   ```
   docker-compose build
   docker-compose up
   ```
5. Access frontend: http://localhost:3000

CI/CD:
- Start Jenkins (recommended in Docker):
  ```
  docker run -d -p 8080:8080 -p 50000:50000     -v jenkins_home:/var/jenkins_home     -v /var/run/docker.sock:/var/run/docker.sock     --name jenkins jenkins/jenkins:lts
  ```
- Import the Jenkinsfile from repository.

Security:
- Run `tfsec terraform/environments/dev` to scan Terraform code.
- Run `trivy image <image>` to scan container images.

