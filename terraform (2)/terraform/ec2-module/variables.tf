variable "vpc_id" {}

variable "public_subnet_id" {}

variable "private_subnet_id" {}

variable "public_subnet_id1" {}

variable "ports" {
    type = list(number)
    default = []
}

variable "image_id" {
  type = string
  default = ""

}

variable "instance_type" {
  type = string
  default = ""
}

variable "instance_name" {
  type = string
  default = ""
}

variable "iamprofilearn" {}