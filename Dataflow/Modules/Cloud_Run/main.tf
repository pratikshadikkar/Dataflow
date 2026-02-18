# # resource "google_cloud_run_v2_service" "batch" {
# #   name     = "batch-processor"
# #   location = var.region

# #   template {
# #     service_account = var.service_account_email

# #     containers {
# #       image = var.container_image

# #       env {
# #         name  = "RAW_BUCKET"
# #         value = var.raw_bucket
# #       }

# #       env {
# #         name  = "OUT_BUCKET"
# #         value = var.out_bucket
# #       }

# #       env {
# #         name  = "PROJECT_ID"
# #         value = var.project_id
# #       }

# #       env {
# #         name  = "REGION"
# #         value = var.region
# #       }
# #     }
# #   }
# # }

# resource "google_cloud_run_v2_service" "service" {
#   name     = var.service_name
#   location = var.region
#   project  = var.project

#   template {
#     service_account = var.service_account_email

#     containers {
#       image = var.image

#       env {
#         name  = "PROJECT_ID"
#         value = var.project
#       }
#       env {
#         name  = "REGION"
#         value = var.region
#       }
#       env {
#         name  = "RAW_BUCKET"
#         value = var.raw_bucket
#       }
#       env {
#         name  = "OUT_BUCKET"
#         value = var.out_bucket
#       }
#     }
#   }
# }

# resource "google_cloud_run_service_iam_member" "invoker" {
#   service  = google_cloud_run_v2_service.service.name
#   location = var.region
#   project  = var.project
#   role     = "roles/run.invoker"
#   member   = "serviceAccount:${var.pubsub_sa}"
# }