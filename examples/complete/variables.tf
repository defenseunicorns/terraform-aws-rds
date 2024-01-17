variable "name_prefix" {
  description = "The prefix to use when naming all resources"
  type        = string
  validation {
    condition     = length(var.name_prefix) <= 20
    error_message = "The name prefix cannot be more than 20 characters"
  }
}

variable "region" {
  description = "The AWS region to deploy into"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
  default     = "10.200.0.0/16"
}

variable "secondary_cidr_blocks" {
  description = "Secondary CIDR block to use for the VPC"
  type        = list(string)
  default     = ["100.64.0.0/16"]
}

variable "iam_role_permissions_boundary" {
  description = "ARN of a permissions boundary policy to use when creating IAM roles"
  type        = string
  default     = null
}

variable "rds_engine" {
  description = "The database engine to use."
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "The database engine version."
  type        = string
  default     = "15.3"
}

variable "rds_family" {
  description = "The family of the DB parameter group."
  type        = string
  default     = "postgres15"
}

variable "rds_major_engine_version" {
  description = "The major version of the engine that this option group should be associated with."
  type        = string
  default     = "15"
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t4g.large"
}

variable "rds_db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
  default     = "example"
}

variable "rds_username" {
  description = "Username for the master DB user."
  type        = string
  default     = "exampleadmin"
}

variable "rds_manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager"
  type        = bool
  default     = true
}

variable "rds_password" {
  description = <<EOF
  Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.
  The password provided will not be used if the variable create_random_password is set to true.
  EOF
  type        = string
  default     = null
  sensitive   = true
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "The upper limit (in gigabytes) to which Amazon RDS can automatically scale the storage of the DB instance."
  type        = number
  default     = 40
}

variable "rds_deletion_protection" {
  description = "If the DB instance should have deletion protection enabled."
  type        = bool
  default     = false
}
