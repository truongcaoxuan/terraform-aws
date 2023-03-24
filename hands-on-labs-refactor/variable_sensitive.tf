variable "first_name" {
  type      = string
  sensitive = true
  default   = "Terraform"
}

variable "last_name" {
  type      = string
  sensitive = true
  default   = "Tom"
}

variable "phone_number" {
  type      = string
  sensitive = true
  default   = "867-5309"
}

locals {
  contact_info_sensitive = {
    first_name   = var.first_name
    last_name    = var.last_name
    phone_number = var.phone_number
  }
  my_number = nonsensitive(var.phone_number)
}

