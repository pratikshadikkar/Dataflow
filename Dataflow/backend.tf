terraform {
  backend "gcs" {
    bucket = "deloitte-tfstate"
    prefix = "embedding-search/state"
  }
}