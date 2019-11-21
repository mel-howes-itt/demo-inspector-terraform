variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}

variable "AMI" {
  type = "map"
  default = {
    eu-west-1 = "ami-03ef731cc103c9f09"
  }
}

variable "REGION" {
  default = "eu-west-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "INSTANCE_COUNT" {
  default = "2"
}

variable "SG_DESCRIPTION" {
  default = "Allow SSH from all IP addresses"
}

variable "SG_PORT" {
  default = "22"
}

variable "SG_PROTOCOL" {
  default = "tcp"
}

variable "SG_CIDR" {
  default = "0.0.0.0/0"
}

variable "SG_PORT2" {
  default = "443"
}

variable "SG_PROTOCOL2" {
  default = "tcp"
}

variable "SG_CIDR2" {
  default = "0.0.0.0/0"
}

variable "KEY_NAME" {
  default = "MyKeyName"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "C:\\MyPath\\MyKeyName.pem"
}