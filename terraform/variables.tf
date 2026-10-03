variable "project_name" {
  description = "Project name"
  type        = string
  default     = "caseauth"
}

variable "environment" {
  description = "Deployment env"
  type        = string
  default     = "hackathon"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket for keeping files"
  type        = string
  default     = "caseauth-documents"
}

variable "bedrock_model_id" {
  description = "The model bedrock will use"
  type        = string

  default = "anthropic.claude-sonnet-4-6"
}

variable "trusted_principle_arn" {
  description = "AWS principal allowed to assume the CaseAuth application role"
  type        = string
}
