resource "google_project_service" "service" {
  for_each = toset([
    "vpcaccess",
    "cloudresourcemanager",
    "iam",
  ])

  service = "${each.value}.googleapis.com"
}
