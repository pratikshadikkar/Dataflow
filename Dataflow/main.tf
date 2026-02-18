module "APIs" {
  source     = "./modules/APIs"
  project_id = var.project_id

  gcp_service_list = [
    "aiplatform.googleapis.com",
    "artifactregistry.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudscheduler.googleapis.com",
    "dataflow.googleapis.com",
    "iam.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "secretmanager.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
  ]
}

module "gcs" {
  source = "./modules/gcs"

  project_id = var.project_id
  region     = var.region

  raw_bucket_name = local.raw_bucket_name
  out_bucket_name = local.out_bucket_name
}

module "pubsub" {
  source  = "./modules/pubsub"
  project = var.project_id

  topic_name        = local.pubsub_topic_name
  subscription_name = local.pubsub_subscription_name

  raw_bucket_name = module.gcs.raw_bucket_name
}

module "iam" {
  source  = "./modules/iam"
  project = var.project_id

  pubsub_topic_name  = module.pubsub.topic_name
  raw_bucket_name    = module.gcs.raw_bucket_name
  display_name       = var.display_name
  account_id   = local.sa_account_id

  project_roles = [
    "roles/storage.objectAdmin",
    "roles/pubsub.publisher",
    "roles/aiplatform.user",
    "roles/run.invoker",
    "roles/logging.logWriter"
  ]
}

module "cloudfunction" {
  source = "./modules/cloudfunction"

  project_id = var.project_id
  region     = var.region

  function_name = local.function_name
  entry_point  = "ingest_pubsub"
  source_dir   = "./function_src"

  raw_bucket = module.gcs.raw_bucket_name
  out_bucket = module.gcs.out_bucket_name

  service_account_email = module.iam.service_account_email
  pubsub_topic          = module.pubsub.topic_id

  depends_on = [module.iam]
}