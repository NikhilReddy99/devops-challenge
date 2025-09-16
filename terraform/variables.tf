# Global variables (override in environment modules if needed)
variable "cluster_context" {
  description = "kubeconfig context to use"
  type        = string
  default     = "minikube"
}