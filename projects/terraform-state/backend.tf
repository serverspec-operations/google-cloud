terraform {
  backend "gcs" {
    bucket = "terraform-state-serverspec-operations"
    prefix = "projects/terraform-state"
  }
}
