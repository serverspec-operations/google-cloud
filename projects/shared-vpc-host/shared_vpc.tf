resource "google_compute_shared_vpc_host_project" "host" {
  project = "shared-vpc-host-434409"
}

resource "google_compute_shared_vpc_service_project" "service" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = "shared-vpc-service-434410"
}
