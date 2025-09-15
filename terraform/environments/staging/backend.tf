terraform {
  backend "s3" {
    bucket         = "mycompany-terraform-states"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
