locals {
  source_bucket = "${var.function_name}-src-${var.project_id}"
}

# Source bucket
resource "google_storage_bucket" "source" {
  name     = local.source_bucket
  location = var.region
  project  = var.project_id
  uniform_bucket_level_access = true
}

# Zip function source
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/function.zip"
}

# Upload zip
resource "google_storage_bucket_object" "zip" {
  name   = "function.zip"
  bucket = google_storage_bucket.source.name
  source = data.archive_file.function_zip.output_path
}

# Cloud Function
resource "google_cloudfunctions_function" "this" {
  name        = var.function_name
  project     = var.project_id
  region      = var.region
  runtime     = var.runtime
  entry_point = var.entry_point
  available_memory_mb = 512

  source_archive_bucket = google_storage_bucket.source.name
  source_archive_object = google_storage_bucket_object.zip.name

  service_account_email = var.service_account_email

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = var.pubsub_topic
  }

  environment_variables = {
    PROJECT_ID = var.project_id
    REGION     = var.region
    RAW_BUCKET = var.raw_bucket
    OUT_BUCKET = var.out_bucket
  }
}