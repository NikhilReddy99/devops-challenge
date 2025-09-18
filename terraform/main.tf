# Assume you have provider blocks etc

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "chat" {
  metadata {
    name = "chat-service"  # or whatever your service namespace is
  }
}

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
      value = "yourpassword"
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

resource "kubernetes_deployment" "chat_service" {
  metadata {
    name      = "chat-service"
    namespace = kubernetes_namespace.chat.metadata[0].name
    labels = {
      app = "chat-service"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "chat-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "chat-service"
        }
      }

      spec {
        container {
          name  = "chat-service"
          image = "nikhilreddy99/chat-service:1.0.0"
          
          port {
            container_port = 8080
            name           = "http"
          }
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
    name      = "chat-service"
    namespace = kubernetes_namespace.chat.metadata[0].name
    labels = {
      app = "chat-service"
    }
  }

  spec {
    selector = {
      app = "chat-service"
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

    type = "ClusterIP"
  }
}

resource "kubernetes_manifest" "chat_service_monitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "ServiceMonitor"
    metadata = {
      name      = "chat-service-monitor"
      namespace = kubernetes_namespace.monitoring.metadata[0].name
      labels = {
        release = helm_release.prometheus.name
      }
    }
    spec = {
      selector = {
        matchLabels = {
          app = "chat-service"
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
