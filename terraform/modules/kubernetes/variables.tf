variable "namespace" {
  type    = string
  default = "staging"
}

variable "namespace_labels" {
  type = map(string)
  default = {}
}

variable "app_name" {
  type    = string
  default = "sample-app"
}

variable "image" {
  type    = string
  default = "localhost:5000/sample-app:latest"
}

variable "replicas" {
  type    = number
  default = 2
}

variable "container_port" {
  type    = number
  default = 80
}

variable "service_port" {
  type    = number
  default = 80
}

variable "service_type" {
  type    = string
  default = "NodePort"
}

variable "resources_requests" {
  type = map(string)
  default = {
    cpu = "100m"
    memory = "128Mi"
  }
}

variable "resources_limits" {
  type = map(string)
  default = {
    cpu = "500m"
    memory = "512Mi"
  }
}

variable "readiness_path" {
  type = string
  default = "/"
}

variable "liveness_path" {
  type = string
  default = "/healthz"
}

variable "environment" {
  type    = string
  default = "staging"
}
