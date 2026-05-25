terraform {
  backend "s3" {
    bucket         = "terraform-atharva-s3-bucket"
    key            = "myApp-ecs/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "Atharva_IAM"
    dynamodb_table = "my-terraform-state-lock"
  }
}