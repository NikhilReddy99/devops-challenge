# Use local minikube for dev
module "minikube" {
  source      = "../../modules/minikube"

  driver        = var.minikube_driver
  cpus          = var.minikube_cpus
  memory        = var.minikube_memory
  disk_size     = var.minikube_disk
  interpreter   = ["bash", "-c"] # Linux/Mac
  # interpreter = ["PowerShell", "-Command"] # Windows

  start_command = "minikube start --driver=${var.minikube_driver} --cpus=${var.minikube_cpus} --memory=${var.minikube_memory} --disk-size=${var.minikube_disk}"
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

module "kubernetes_app" {
  source       = "../../modules/kubernetes"
  namespace    = var.environment
  app_name     = "sample-app"
  image        = var.image_tag
  replicas     = 1
  environment  = var.environment
  depends_on   = [module.minikube]
}
