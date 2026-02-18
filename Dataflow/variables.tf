variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "raw_bucket_base" {
  type = string
}

variable "out_bucket_base" {
  type = string
}

variable "vector_index_name_base" {
  type = string
}

variable "vector_endpoint_name_base" {
  type = string
}

variable "deployed_index_id_base" {
  type = string
}

variable "display_name" {
  type = string
  default = "Cloud Run Batch Processor" 
}