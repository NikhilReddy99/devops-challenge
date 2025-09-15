provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
  config_context = "prod"
}

module "kubernetes_app" {
  source       = "../../modules/kubernetes"
  namespace    = var.environment
  app_name     = "sample-app"
  image        = var.image_tag
  replicas     = var.replicas
  environment  = var.environment
}