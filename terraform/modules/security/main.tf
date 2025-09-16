resource "kubernetes_service_account" "sa" {
  metadata {
    name      = var.sa_name
    namespace = var.namespace
  }
}

resource "kubernetes_role" "limited" {
  metadata {
    name      = "${var.sa_name}-role"
    namespace = var.namespace
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "endpoints"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding" "bind" {
  metadata {
    name      = "${var.sa_name}-rb"
    namespace = var.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.limited.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.sa.metadata[0].name
    namespace = var.namespace
  }
}
