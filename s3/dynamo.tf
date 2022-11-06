resource "aws_dynamodb_table" "tf_locks" {
  name = "tf_locking_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

attribute {
    name = "LockID"
    type = "S"
  }
}