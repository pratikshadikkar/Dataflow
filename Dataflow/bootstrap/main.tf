resource "google_storage_bucket" "tf_state" {
  name     = var.backend_bucket_name
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}