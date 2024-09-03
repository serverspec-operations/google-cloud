resource "google_compute_shared_vpc_host_project" "host" {
  project = "shared-vpc-host-434409"
}

locals {
  projects = [
    "shared-vpc-service-tokyo",
    "shared-vpc-service-us",
    "shared-vpc-service-singapore",
  ]
}

resource "google_compute_shared_vpc_service_project" "service" {
  for_each = toset(local.projects)

  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = each.value
}
