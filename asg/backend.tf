terraform {
    backend "s3" {
      bucket = "tf-learning-and-practice"
      key = "global/asg/terraform.tfstate"
      region = "us-east-2"
      dynamodb_table = "tf_locking_table"
      encrypt = true
    }
}