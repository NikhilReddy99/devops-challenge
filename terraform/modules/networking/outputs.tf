output "network_policy_name" {
  value = kubernetes_network_policy.allow-same-namespace.metadata[0].name
}
