provider "aws" {
  region = "us-east-1"
}

import {
  to = aws_s3_bucket.erikaalban_com
  id = "erikaalban.com"
}

resource "aws_s3_bucket" "erikaalban_com" {
  bucket = "erikaalban.com"
}

resource "aws_s3_bucket_ownership_controls" "erikaalban_com" {
  bucket = aws_s3_bucket.erikaalban_com.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "erikaalban_com" {
  bucket = aws_s3_bucket.erikaalban_com.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "erikaalban_com" {
  bucket = aws_s3_bucket.erikaalban_com.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "erikaalban_com" {
  bucket = aws_s3_bucket.erikaalban_com.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "erikaalban_com" {
  bucket = aws_s3_bucket.erikaalban_com.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "erikaalban_com" {
  bucket = aws_s3_bucket.erikaalban_com.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.erikaalban_com.arn}/*"
      },
    ]
  })

  depends_on = [
    aws_s3_bucket_ownership_controls.erikaalban_com,
    aws_s3_bucket_public_access_block.erikaalban_com
  ]
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.erikaalban_com.website_endpoint
}