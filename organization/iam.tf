data "google_organization" "current" {
  domain = "serverspec-operations.com"
}

resource "google_organization_iam_member" "miyashita" {
  for_each = toset([
    "roles/resourcemanager.organizationAdmin",
    "roles/compute.xpnAdmin",
  ])

  org_id = data.google_organization.current.org_id
  member = "user:miyashita@serverspec-operations.com"
  role   = each.value
}
