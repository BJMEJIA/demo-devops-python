variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
    type = string
    default = "development"
}

variable "vpc_vars" {
  type = object({
    cidr           = string
    private_subnets = list(string)
    public_subnets  = list(string)
  })

  default = {
    cidr           = "10.0.0.0/16"
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  }
}
