variable "base_cidr" {
  description = "The base CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}$", var.base_cidr))
    error_message = "The base_cidr must be a valid CIDR block."
  }
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

variable "vpc_security_group_rules" {
  description = "A list of security group rules to add to the main security group"
  type = list(object({
    name        = string
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []

}

variable "public_subnet_security_group_rules" {
  description = "A list of security group rules to add to each public subnet security group"
  type = list(object({
    name        = string
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
variable "private_subnet_security_group_rules" {
  description = "A list of security group rules to add to each private subnet security group"
  type = list(object({
    name        = string
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
variable "internal_subnet_security_group_rules" {
  description = "A list of security group rules to add to each internal subnet security group"
  type = list(object({
    name        = string
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
variable "firewall_subnet_security_group_rules" {
  description = "A list of security group rules to add to each firewall subnet security group"
  type = list(object({
    name        = string
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
variable "db_subnet_security_group_rules" {
  description = "A list of security group rules to add to each db subnet security group"
  type = list(object({
    name        = string
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}