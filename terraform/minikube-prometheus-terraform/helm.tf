# Deploy Prometheus + Grafana
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "47.3.0"

  create_namespace = false

  set = [
    {
      name  = "grafana.adminPassword"
      value = "admin123"
    },
    {
      name  = "grafana.service.type"
      value = "NodePort"
    },
    {
      name  = "grafana.service.nodePort"
      value = "30007"
    },
    {
      name  = "prometheus.service.type"
      value = "NodePort"
    },
    {
      name  = "prometheus.service.nodePort"
      value = "30008"
    }
  ]
}

# Deploy chat-service app
resource "kubernetes_deployment" "chat_service" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.chat.metadata[0].name
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = "nikhilreddy99/frontend:1.0.0"

          port {
            container_port = 8080
          }

          # If app exposes Prometheus metrics at /metrics
          port {
            container_port = 9090
            name           = "metrics"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "chat_service" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.chat.metadata[0].name
    labels = {
      app = "frontend"
    }
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      name        = "http"
      port        = 8080
      target_port = 8080
    }

    port {
      name        = "metrics"
      port        = 9090
      target_port = 9090
    }

    type = "NodePort"
  }
}

# ServiceMonitor to let Prometheus scrape frontend
resource "kubernetes_manifest" "chat_service_monitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "ServiceMonitor"
    metadata = {
      name      = "frontend-monitor"
      namespace = kubernetes_namespace.monitoring.metadata[0].name
      labels = {
        release = helm_release.prometheus.name
      }
    }
    spec = {
      selector = {
        matchLabels = {
          app = "frontend"
        }
      }
      namespaceSelector = {
        matchNames = [kubernetes_namespace.chat.metadata[0].name]
      }
      endpoints = [
        {
          port     = "metrics"
          interval = "15s"
        }
      ]
    }
  }
}
