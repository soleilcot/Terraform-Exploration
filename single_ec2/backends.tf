terraform {
    backend "s3" {
      bucket = "tf-learning-and-practice"
      key = "workspaces-testing/terraform.tfstate"
      region = "us-east-2"
      dynamodb_table = "tf_locking_table"
      encrypt = true
    }
}