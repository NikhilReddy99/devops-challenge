resource "kubernetes_network_policy" "allow-same-namespace" {
  metadata {
    name      = "allow-same-namespace"
    namespace = var.namespace
  }

  spec {
    pod_selector {
      match_labels = {
        app = var.app_label
      }
    }

    ingress {
      from {
        namespace_selector {}
      }
    }

    policy_types = ["Ingress"]
  }
}
