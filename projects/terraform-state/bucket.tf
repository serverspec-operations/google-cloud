resource "google_storage_bucket" "terraform_state" {
  name     = "terraform-state-serverspec-operations"
  location = "asia-northeast1"
}

resource "google_storage_bucket_iam_member" "terraform" {
  bucket = "terraform-state-serverspec-operations"
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:terraform@shared-vpc-host-434409.iam.gserviceaccount.com"
}
