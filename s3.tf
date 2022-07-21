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
  acl    = "private"
  #region = "us-east-1"
  versioning {
    enabled = true
  }
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

  # I am using default AES256 encryption instead of KSM
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        #kms_master_key_id = aws_kms_key.mykey.arn
        #sse_algorithm     = "aws:kms"
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls   = true
  block_public_policy = true
}
