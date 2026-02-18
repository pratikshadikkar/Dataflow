# output "email" {
#   value = google_service_account.batch.email
# }


output "service_account_email" {
  value = google_service_account.fn.email
}