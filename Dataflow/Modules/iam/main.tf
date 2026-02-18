data "google_project" "current" {}

resource "google_service_account" "processor" {
  account_id   = var.account_id
  display_name = "Batch Processor SA"
  project      = var.project
}

resource "google_project_iam_member" "roles" {
  for_each = toset(var.project_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.processor.email}"
}

resource "google_service_account" "fn" {
  account_id   = "cf-exec-sa"
  display_name = var.display_name
}

#resource "google_storage_bucket_iam_member" "gcf_build_reader" {
  #bucket = "gcf-sources-${data.google_project.current.number}-us-central1"
  #role   = "roles/storage.objectViewer"
  #member = "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com"
#}
### Check where the bucket is used?