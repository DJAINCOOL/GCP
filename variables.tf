variable "project_id" {
  type    = string
  default = "terraform-gcp"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "credentials_file" {
  type    = string
  default = ""
}

variable "remote_state_bucket" {
  type    = string
  default = "my-terraform-state-poc"
}

variable "remote_state_prefix" {
  type    = string
  default = "terraform/state"
}
