########################################
# Module: k8s
# Purpose: create namespace and an example deployment + service
# Note: This module expects the root to configure the kubernetes provider and ensures
# resources are created after minikube start (use module depends_on in calling module).
########################################

resource "kubernetes_namespace_v1" "ns" {
  metadata {
    name = var.namespace
    labels = var.namespace_labels
  }
}

resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace_v1.ns.metadata[0].name
    labels = {
      app = var.app_name
      env = var.environment
    }
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = var.image
          port {
            container_port = var.container_port
          }
          resources {
            limits = var.resources_limits
            requests = var.resources_requests
          }
          readiness_probe {
            http_get {
              path = var.readiness_path
              port = var.container_port
            }
            initial_delay_seconds = 5
            period_seconds = 5
          }
          liveness_probe {
            http_get {
              path = var.liveness_path
              port = var.container_port
            }
            initial_delay_seconds = 15
            period_seconds = 20
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "svc" {
  metadata {
    name      = "${var.app_name}-svc"
    namespace = kubernetes_namespace_v1.ns.metadata[0].name
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = var.service_type
  }
}
