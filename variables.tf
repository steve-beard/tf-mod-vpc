variable "base_cidr" {
  description = "The base CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}$", var.base_cidr))
    error_message = "The base_cidr must be a valid CIDR block."
  }
}

variable "create_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = true
}

variable "azs" {
  description = "The availability zones to use"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "firewall" {
  description = "Whether to create the firewall subnet"
  type        = bool
  default     = false
}

variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "us-east-1"
}

