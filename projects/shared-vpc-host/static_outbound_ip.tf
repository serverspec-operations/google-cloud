resource "google_compute_network" "static_outbound_ip" {
  name                    = "static-outbound-ip-network"
  auto_create_subnetworks = false
}

### us-central-1
resource "google_compute_subnetwork" "static_outbound_ip_us" {
  name          = "static-outbound-ip-subnet-us"
  region        = "us-central1"
  network       = google_compute_network.static_outbound_ip.id
  ip_cidr_range = "10.0.0.0/28"
}

resource "google_compute_router" "static_outbound_ip_us" {
  name    = "static-outbound-ip-router-us"
  network = google_compute_network.static_outbound_ip.id
  region  = "us-central1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_address" "static_outbound_ip_us" {
  name   = "static-outbound-ip-address-us"
  region = "us-central1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router_nat" "static_outbound_ip_us" {
  name                               = "static-outbound-ip-nat-us"
  region                             = "us-central1"
  router                             = google_compute_router.static_outbound_ip_us.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_outbound_ip_us.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_vpc_access_connector" "static_outbound_ip_us" {
  # https://cloud.google.com/vpc/docs/configure-serverless-vpc-access?hl=ja
  # [名前] フィールドに、Compute Engine の命名規則に沿ってコネクタの名前を入力します。
  # ただし、名前の長さは 21 文字未満とし、ハイフン（-）は 2 文字としてカウントする必要があります。
  # Error creating Connector: googleapi: Error 400: Connector ID must follow the pattern ^[a-z][-a-z0-9]{0,23}[a-z0-9]$
  # 実際には25文字っぽい
  name          = "static-ip-us"
  machine_type  = "f1-micro"
  min_instances = 2
  max_instances = 3
  region        = "us-central1"

  subnet {
    name = google_compute_subnetwork.static_outbound_ip_us.name
  }
}

### asia-northeast1

resource "google_compute_address" "static_outbound_ip_tokyo" {
  name   = "static-outbound-ip-address-tokyo"
  region = "asia-northeast1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router" "static_outbound_ip_tokyo" {
  name    = "static-outbound-ip-router-tokyo"
  network = google_compute_network.static_outbound_ip.id
  region  = "asia-northeast1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router_nat" "static_outbound_ip_tokyo" {
  name                               = "static-outbound-ip-nat-tokyo"
  region                             = "asia-northeast1"
  router                             = google_compute_router.static_outbound_ip_tokyo.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_outbound_ip_tokyo.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_subnetwork" "static_outbound_ip_tokyo" {
  name          = "static-outbound-ip-subnet-tokyo"
  region        = "asia-northeast1"
  network       = google_compute_network.static_outbound_ip.id
  ip_cidr_range = "10.0.0.16/28"
}

resource "google_vpc_access_connector" "static_outbound_ip_tokyo" {
  name          = "static-ip-tokyo"
  region        = "asia-northeast1"
  machine_type  = "e2-micro"
  min_instances = 2
  max_instances = 3

  subnet {
    name = google_compute_subnetwork.static_outbound_ip_tokyo.name
  }
}

### asia-southeast1

resource "google_compute_subnetwork" "static_outbound_ip_singapore" {
  name          = "static-ip-subnet-singapore"
  region        = "asia-southeast1"
  network       = google_compute_network.static_outbound_ip.id
  ip_cidr_range = "10.0.0.32/28"
}

resource "google_compute_address" "static_outbound_ip_singapore" {
  name   = "static-outbound-ip-address-singapore"
  region = "asia-southeast1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router" "static_outbound_ip_singapore" {
  name    = "static-outbound-ip-router-singapore"
  network = google_compute_network.static_outbound_ip.id
  region  = "asia-southeast1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router_nat" "static_outbound_ip_singapore" {
  name                               = "static-outbound-ip-nat-singapore"
  region                             = "asia-southeast1"
  router                             = google_compute_router.static_outbound_ip_singapore.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_outbound_ip_singapore.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_vpc_access_connector" "static_outbound_ip_singapore" {
  name          = "static-ip-singapore"
  region        = "asia-southeast1"
  machine_type  = "e2-micro"
  min_instances = 2
  max_instances = 3

  subnet {
    name = google_compute_subnetwork.static_outbound_ip_singapore.name
  }
}
