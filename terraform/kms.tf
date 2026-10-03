resource "aws_kms_key" "documents" {
  description             = "KMS key for CaseAuth document authenticating"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.project_name}-documents"
  }
}

resource "aws_kms_alias" "documents" {
  name          = "alias/${var.project_name}-documents"
  target_key_id = aws_kms_key.documents.key_id
}

