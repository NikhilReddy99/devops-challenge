variable "namespace" {
  description = "Kubernetes namespace to create/use"
  type        = string
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
  default     = 1
}

variable "image" {
  description = "Container image for the sample app"
  type        = string
  default     = "nginx:1.25"
}

variable "app_name" {
  description = "Application name / label"
  type        = string
  default     = "sample-app"
}
