output "function_name" {
  value = google_cloudfunctions_function.this.name
}

output "source_bucket" {
  value = google_storage_bucket.source.name
}