provider "aws" {
  region  = var.region
  profile = "Atharva_IAM"

  default_tags {
    tags = {
      "Automation"  = "terraform"
      "Project"     = var.project_name
      "Environment" = var.environment
    }
  }
}