resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt s3 bucket objects"
  deletion_window_in_days = 10
  tags = {
    Name        = "sftp-s3-key"
    environment = local.environment
    Owner       = var.owner_name
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "sftp-bucket-ny1"

  tags = {
    Name        = local.sftp_bucket_name
    environment = local.environment
    Owner       = var.owner_name,
    DataType    = "SFTP files"
  }

  /* 
  logging {
    target_bucket = "my-tf-test-bucket-1"
    target_prefix = "s3logs/us-east-1/"
  }
  */

}

resource "aws_s3_bucket_versioning" "b_version" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "b_encryption" {
    bucket = aws_s3_bucket.b.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_acl" "b_bucket_acl" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls   = true
  block_public_policy = true
}
