variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "public_subnet_ids" {
  description = "Map of public subnet IDs keyed by availability zone"
  type        = map(string)
}

variable "alb_security_group_id" {
  description = "Security group ID assigned to the ALB"
  type        = string
}

variable "target_port" {
  description = "Port used by the application targets"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "HTTP health-check path"
  type        = string
  default     = "/"
}

variable "enable_deletion_protection" {
  description = "Whether ALB deletion protection is enabled"
  type        = bool
  default     = false
}