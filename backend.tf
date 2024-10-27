terraform {
  backend "s3" {
    encrypt = true
    bucket  = "terraform-backend-bucket-rav261020241226"
    // dynamodb_table = "ravee-webserver-lock"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}