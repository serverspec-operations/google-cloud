resource "google_storage_bucket" "terraform_state" {
  name     = "terraform-state-serverspec-operations"
  location = "asia-northeast1"
}
