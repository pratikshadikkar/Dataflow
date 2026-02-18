resource "google_pubsub_topic" "ingest" {
  name    = var.topic_name
  project = var.project
}

resource "google_pubsub_subscription" "push" {
  name  = var.subscription_name
  topic = google_pubsub_topic.ingest.name
  project = var.project
  ack_deadline_seconds = 10
}

resource "google_storage_notification" "raw_events" {
  bucket         = var.raw_bucket_name
  topic          = google_pubsub_topic.ingest.id
  payload_format = "JSON_API_V1"
  event_types    = ["OBJECT_FINALIZE"]

  depends_on = [google_pubsub_topic_iam_member.gcs_publisher]
}