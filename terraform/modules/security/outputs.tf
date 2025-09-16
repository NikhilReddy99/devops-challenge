output "service_account" {
  value = kubernetes_service_account.sa.metadata[0].name
}
