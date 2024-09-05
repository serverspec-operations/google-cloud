terraform {
  backend "gcs" {
    bucket = "terraform-state-serverspec-operations"
    prefix = "organization/serverspec-opertions.com"
  }
}
