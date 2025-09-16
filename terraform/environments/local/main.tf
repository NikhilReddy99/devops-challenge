provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

module "kubernetes" {
  source    = "../../modules/kubernetes"
  namespace = "dev"
  replicas  = 1
  image     = "nikhilreddy99/frontend:1.0.0"
  app_name  = "frontend"
}

module "networking" {
  source    = "../../modules/networking"
  namespace = module.kubernetes.namespace
  app_label = "frontend"
}

module "security" {
  source    = "../../modules/security"
  namespace = module.kubernetes.namespace
  sa_name   = "frontend"
}

output "namespace" {
  value = module.kubernetes.namespace
}
