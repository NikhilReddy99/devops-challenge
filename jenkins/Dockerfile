FROM jenkins/agent:latest

USER root

# Install base tools
RUN apt-get update && apt-get install -y \
    curl wget unzip git docker.io python3-pip gnupg lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
ENV KUBECTL_VERSION=v1.30.0
RUN curl -sS -L https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install tfsec
RUN curl -sSL https://github.com/aquasecurity/tfsec/releases/latest/download/tfsec-linux-amd64 -o /usr/local/bin/tfsec \
    && chmod +x /usr/local/bin/tfsec

# Install kube-score
RUN curl -sSL https://github.com/zegl/kube-score/releases/latest/download/kube-score_ubuntu_amd64 \
    -o /usr/local/bin/kube-score \
    && chmod +x /usr/local/bin/kube-score

# Install trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh

# Install checkov
RUN pip3 install --no-cache-dir --break-system-packages checkov

# Cleanup
RUN apt-get clean

USER jenkins
