variable "driver" {
  type        = string
  default     = "docker"
  description = "minikube driver (docker|hyperv|virtualbox)"
}

variable "cpus" {
  type  = number
  default = 2
}

variable "memory" {
  type    = number
  default = 3072
  description = "MB of memory to allocate to minikube (adjust to fit your Docker Desktop allocation)"
}

variable "disk_size" {
  type    = string
  default = "20g"
}

variable "interpreter" {
  type = list(string)
  default = ["bash", "-c"]
  description = "Interpreter used by local-exec (override to PowerShell on Windows)"
}

# You can override start and stop commands directly for special environment needs
variable "start_command" {
  type = string
  default = "minikube start --driver=${var.driver} --cpus=${var.cpus} --memory=${var.memory} --disk-size=${var.disk_size}"
}

variable "stop_command" {
  type = string
  default = "minikube stop"
}
