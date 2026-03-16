terraform {
  backend "s3" {
    bucket         = "three-tier-architecture-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "three-tier-architecture-terraform-lock"
    encrypt        = true
  }
}
