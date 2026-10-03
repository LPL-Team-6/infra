resource "aws_iam_role" "caseauth" {
  name = "${var.project_name}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          AWS = var.trusted_principle_arn
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-app-role"
  }
}

resource "aws_iam_role_policy" "caseauth" {
  name = "${var.project_name}-app-role"
  role = aws_iam_role.caseauth.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "TextractAnalysis"
        Effect = "Allow"

        Action = [
          "textract:AnalyzeID",
          "textract:AnalyzeDocument"
        ]

        Resource = "*"
      },

      {
        Sid    = "InvokeBedrockModel"
        Effect = "Allow"

        Action = [
          "bedrock:InvokeModel"
        ]

        Resource = [
          "arn:aws:bedrock:${var.aws_region}::foundation-model/${var.bedrock_model_id}"
        ]
      },

      {
        Sid    = "ListDocumentBucket"
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = [
          aws_s3_bucket.documents.arn
        ]
      },

      {
        Sid    = "AccessDocumentObjects"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = [
          "${aws_s3_bucket.documents.arn}/*"
        ]
      },

      {
        Sid    = "UseDocumentEncryptionKey"
        Effect = "Allow"

        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ]

        Resource = [
          aws_kms_key.documents.arn
        ]
      }
    ]
  })
}
