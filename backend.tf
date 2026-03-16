terraform {
  backend "s3" {
    bucket       = "three-tier-architecture-terraform-state"
    key          = "prod/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
