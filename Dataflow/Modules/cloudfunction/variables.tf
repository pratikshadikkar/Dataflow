variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "function_name" {
  type = string
}

variable "entry_point" {
  type = string
}

variable "runtime" {
  type    = string
  default = "python311"
}

variable "source_dir" {
  type = string
}

variable "raw_bucket" {
  type = string
}

variable "out_bucket" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "pubsub_topic" {
  type = string
}