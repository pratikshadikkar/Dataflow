resource "google_storage_bucket" "raw" {
  name     = var.raw_bucket_name
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "out" {
  name     = var.out_bucket_name
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
}