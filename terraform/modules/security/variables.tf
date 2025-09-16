variable "namespace" {
  description = "Namespace to create security resources in"
  type        = string
}

variable "sa_name" {
  description = "Service account name"
  type        = string
  default     = "app-sa"
}