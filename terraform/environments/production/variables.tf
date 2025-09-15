variable "environment" {
  type    = string
  default = "prod"
}

variable "image_tag" {
  type    = string
  default = "myregistry.company.com/sample-app:prod"
}

variable "replicas" {
  type    = number
  default = 4
}
