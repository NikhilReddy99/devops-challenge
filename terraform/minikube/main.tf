terraform {
  required_version = ">= 1.5"
}

provider "local" {}

# Create Minikube cluster using null_resource
resource "null_resource" "minikube_cluster" {
  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      minikube status || minikube start --driver=docker
    EOT
  }
}

# Kubernetes provider to interact with cluster
provider "kubernetes" {
  host                   = "https://$(minikube ip):8443"
  client_certificate     = file("~/.minikube/client.crt")
  client_key             = file("~/.minikube/client.key")
  cluster_ca_certificate = file("~/.minikube/ca.crt")
}
