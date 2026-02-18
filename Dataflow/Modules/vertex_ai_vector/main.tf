# resource "google_vertex_ai_index" "vector_index" {
#   project      = var.project_id
#   region       = var.region
#   display_name = var.vector_index_name

#   metadata {
#     contents_delta_uri = "gs://${var.out_bucket}/"

#     config {
#       dimensions                 = var.embedding_dimensions
#       approximate_neighbors_count = 100
#       distance_measure_type       = "COSINE_DISTANCE"
#       feature_norm_type           = "UNIT_L2_NORM"

#       algorithm_config {
#         tree_ah_config {
#           leaf_node_embedding_count    = 500
#           leaf_nodes_to_search_percent = 10
#         }
#       }
#     }
#   }

#   index_update_method = "BATCH_UPDATE"
# }

#   resource "google_vertex_ai_index_endpoint" "vector_endpoint" {
#   project      = var.project_id
#   region       = var.region
#   display_name = var.vector_endpoint_name

#   public_endpoint_enabled = true
# }

# resource "google_vertex_ai_index_endpoint_deployed_index" "deploy_index" {
#   deployed_index_id  = "embedded_index_12345_tf"
#   index_endpoint     = google_vertex_ai_index_endpoint.vector_endpoint.id
#   index              = google_vertex_ai_index.vector_index.id
# }
