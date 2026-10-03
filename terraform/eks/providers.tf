provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "caseauth"
      Environment = "hackathon"
      ManagedBy   = "Terraform"
    }
  }
}
