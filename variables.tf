variable "project_id" {
  type    = string
  default = "project-da650e2e-4990-4992-b69"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "remote_state_bucket" {
  type    = string
  default = "my-terraform-state-poc"
}

variable "remote_state_prefix" {
  type    = string
  default = "terraform/state"
}
