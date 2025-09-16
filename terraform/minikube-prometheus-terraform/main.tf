terraform {
  required_version = ">= 1.5"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
  }
}

# Kubernetes provider (Minikube)
provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}

# Helm provider using same kubeconfig
provider "helm" {
  kubernetes = {
    config_path = pathexpand("~/.kube/config")
  }
}

# Namespace for monitoring (Prometheus + Grafana)
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Namespace for chat-service app
resource "kubernetes_namespace" "chat" {
  metadata {
    name = "chat-service"
  }
}
