resource "google_organization_iam_binding" "compute_xpnAdmin" {
  org_id = data.google_organization.current.org_id
  role   = "roles/compute.xpnAdmin"

  members = [
    "user:miyashita@serverspec-operations.com"
  ]
}
