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

data "google_folder" "shared_vpc" {
  folder = "667746935773"
}

resource "google_folder_iam_member" "terraform" {
  for_each = toset([
    "roles/resourcemanager.folderIamAdmin",
    "roles/compute.xpnAdmin",
  ])

  folder = data.google_folder.shared_vpc.id
  member = "serviceAccount:${data.google_service_account.terraform.email}"
  role   = each.value
}
