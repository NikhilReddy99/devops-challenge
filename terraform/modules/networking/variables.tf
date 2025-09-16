variable "namespace" {
  description = "Namespace to create networking policy in"
  type        = string
}
variable "app_label" {
  description = "Label of app to allow ingress to"
  type        = string
  default     = "sample-app"
}
