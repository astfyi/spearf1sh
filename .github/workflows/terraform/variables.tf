variable "aws_access_key" {
  type        = string
  description = "AWS access key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  sensitive   = true
}

variable "gh_token" {
  type        = string
  description = "GitHub access token"
  sensitive   = true
}
