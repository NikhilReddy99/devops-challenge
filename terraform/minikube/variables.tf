variable "minikube_driver" {
  description = "Driver to use for Minikube"
  type        = string
  default     = "docker"
}

variable "minikube_cpus" {
  description = "Number of CPUs for Minikube VM"
  type        = number
  default     = 2
}

variable "minikube_memory" {
  description = "Memory in MB for Minikube VM"
  type        = number
  default     = 4096
}
