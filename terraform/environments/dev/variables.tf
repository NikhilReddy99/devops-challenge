variable "minikube_driver" {
  type    = string
  default = "docker"
}

variable "minikube_cpus" {
  type    = number
  default = 2
}

variable "minikube_memory" {
  type    = number
  default = 3072
}

variable "minikube_disk" {
  type    = string
  default = "20g"
}

variable "kubeconfig_path" {
  type    = string
  default = pathexpand("~/.kube/config")
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "image_tag" {
  type    = string
  default = "localhost:5000/sample-app:dev"
}
