variable azure_subscription_id {
  type = "string"
}

variable azure_client_id {
  type = "string"
}

variable azure_client_secret {
  type = "string"
}

variable azure_tenant_id {
  type = "string"
}

variable "vm_hostname1" {
  type = "string"
  default = "TUSMAZWIAD"
}

variable "vm_hostname2" {
  type = "string"
  default = "TUSMAZWIAQ"
}

variable "vm_hostname3" {
  type = "string"
  default = "TUSMAZWIAU"
}

variable "vm_hostname4" {
  type = "string"
  default = "TUSMAZWIAP"
}

variable "admin_username" {
  type = "string"
}

variable "admin_password" {
  type = "string"
}

variable "ARG" {
  default ="TestResourceGroup2"
}
