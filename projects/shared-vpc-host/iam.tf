resource "google_organization_iam_member" "compute_xpnAdmin" {
  org_id = data.google_organization.current.org_id
  member = "user:miyashita@serverspec-operations.com"
  role   = "roles/compute.xpnAdmin"
}

data "google_service_account" "terraform" {
  account_id = "terraform"
}

resource "google_project_iam_member" "terraform" {
  for_each = toset([
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.roleViewer",
    "roles/iam.roleAdmin",
    "roles/storage.admin",
    "roles/compute.networkAdmin",
    "roles/vpcaccess.admin",
  ])

  project = data.google_project.current.project_id
  role    = each.value
  member  = "serviceAccount:${data.google_service_account.terraform.email}"
}

resource "google_organization_iam_member" "terraform" {
  for_each = toset([
    "roles/resourcemanager.organizationAdmin",
    "roles/compute.xpnAdmin",
  ])

  org_id = data.google_organization.current.org_id
  member = "serviceAccount:${data.google_service_account.terraform.email}"
  role   = each.value
}
