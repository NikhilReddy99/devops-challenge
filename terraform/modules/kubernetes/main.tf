resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
    labels = {
      env = var.namespace
    }
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.this.metadata[0].name
    labels = {
      app = var.app_name
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
            container_port = 80
          }

          # Add minimal securityContext for runtime safety
          security_context {
            run_as_non_root = true
            run_as_user     = 1000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name      = "${var.app_name}-svc"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  spec {
    selector = {
      app = var.app_name
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
