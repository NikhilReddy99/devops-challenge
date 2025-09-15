variable "environment" {
  type    = string
  default = "staging"
}

variable "image_tag" {
  type    = string
  default = "localhost:5000/sample-app:staging"
}

variable "replicas" {
  type    = number
  default = 2
}
