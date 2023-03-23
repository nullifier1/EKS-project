variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}
variable "database_login" {
  type        = string
  description = "login for the database user"
  sensitive   = true
}
variable "database_password" {
  type        = string
  description = "Password for the database user"
  sensitive   = true
}