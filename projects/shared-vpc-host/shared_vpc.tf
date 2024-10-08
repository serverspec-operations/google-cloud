resource "google_compute_shared_vpc_host_project" "host" {
  project = "shared-vpc-host-434409"
}

resource "google_compute_shared_vpc_service_project" "service" {
  for_each = toset([
    "shared-vpc-service-tokyo",
    "shared-vpc-service-us",
    "shared-vpc-service-singapore",
  ])

  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = each.value
}
