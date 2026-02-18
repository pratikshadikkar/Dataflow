locals {
  env    = terraform.workspace
  region = var.region

  raw_bucket_name = "doc-raw-input-${local.env}"
  out_bucket_name = "doc-embedding-output-${local.env}"

  function_name = "ingest-pubsub-${local.env}"
  raw_bucket    = "raw-bucket-${local.env}"
  out_bucket    = "processed-bucket-${local.env}"

  pubsub_topic_name        = "doc-ingest-topic-${local.env}"
  pubsub_subscription_name = "doc-ingest-push-${local.env}"

  sa_account_id = "batch-processor-sa-${local.env}"

  vector_index_name     = "${var.vector_index_name_base}-${local.env}"
  vector_endpoint_name = "${var.vector_endpoint_name_base}-${local.env}"
  deployed_index_id    = "${var.deployed_index_id_base}-${local.env}"
}