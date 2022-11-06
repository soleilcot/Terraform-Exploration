provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "tf_state" {
    bucket = "tf-learning-and-practice"

    # Don't allow the bucket to be deleted via tf
    lifecycle {
      prevent_destroy = true
    }
}
# Enable Versioning to allow easy fallback
resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.tf_state.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.tf_state.id

  # Encrypt files at rest
  rule {
    apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
    bucket = aws_s3_bucket.tf_state.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}