resource "google_project_service" "serverless_vpc_access" {
  service = "vpcaccess.googleapis.com"
}
