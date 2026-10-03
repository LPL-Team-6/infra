output "document_bucket_name" {
  description = "Name of CaseAuth's Document Bucket"
  value       = aws_s3_bucket.documents.bucket
}

output "document_bucket_arn" {
  description = "ARN of CaseAuth document bucket"
  value       = aws_s3_bucket.documents.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt documents"
  value       = aws_kms_key.documents.arn
}

output "application_role_arn" {
  description = "ARN of the CaseAuth application IAM role"
  value       = aws_iam_role.caseauth.arn
}

output "bedrock_model_id" {
  description = "Bedrock model the application is allowed to invoke"
  value       = var.bedrock_model_id
}
