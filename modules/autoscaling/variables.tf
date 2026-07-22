variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "private_subnet_ids" {
  description = "Map of private subnet IDs keyed by availability zone"
  type        = map(string)
}

variable "application_security_group_id" {
  description = "Security group ID assigned to application instances"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile assigned to EC2 instances"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}

variable "cpu_target_value" {
  description = "Target average CPU utilization percentage for the Auto Scaling Group"
  type        = number
  default     = 50

  validation {
    condition     = var.cpu_target_value > 0 && var.cpu_target_value <= 100
    error_message = "cpu_target_value must be greater than 0 and less than or equal to 100."
  }
}