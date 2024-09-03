resource "google_organization_iam_member" "compute_xpnAdmin" {
  org_id = data.google_organization.current.org_id
  member = "user:miyashita@serverspec-operations.com"
  role   = "roles/compute.xpnAdmin"
}
