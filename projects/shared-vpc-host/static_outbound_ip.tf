resource "google_compute_network" "static_outbound_ip" {
  name                    = "static-outbound-ip-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "static_outbound_ip" {
  name          = "static-outbound-ip-subnet"
  network       = google_compute_network.static_outbound_ip.id
  ip_cidr_range = "10.0.0.0/28"
}

resource "google_compute_router" "static_outbound_ip" {
  name    = "static-outbound-ip-router"
  network = google_compute_network.static_outbound_ip.id
}

resource "google_compute_address" "static_outbound_ip" {
  name = "static-outbound-ip"
}

resource "google_compute_router_nat" "static_outbound_ip" {
  name                               = "static-outbound-ip-nat"
  router                             = google_compute_router.static_outbound_ip.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_outbound_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"
}

resource "google_vpc_access_connector" "static_outbound_ip" {
  # https://cloud.google.com/vpc/docs/configure-serverless-vpc-access?hl=ja
  # [名前] フィールドに、Compute Engine の命名規則に沿ってコネクタの名前を入力します。
  # ただし、名前の長さは 21 文字未満とし、ハイフン（-）は 2 文字としてカウントする必要があります。
  # Error creating Connector: googleapi: Error 400: Connector ID must follow the pattern ^[a-z][-a-z0-9]{0,23}[a-z0-9]$
  name          = "static-ip-connector"
  machine_type  = "f1-micro"
  min_instances = 2
  max_instances = 3

  subnet {
    name = google_compute_subnetwork.static_outbound_ip.name
  }
}
