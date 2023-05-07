resource "google_iam_workload_identity_pool" "gha" {
  project = local.project
  workload_identity_pool_id = "crewpicker-gha"
  display_name = "gha"
  description = "GHA"
}

resource "google_iam_workload_identity_pool_provider" "gha" {
  project = local.project
  workload_identity_pool_id = google_iam_workload_identity_pool.gha.workload_identity_pool_id
  workload_identity_pool_provider_id = "crewpicker-gha-provider"
  attribute_mapping = {
    "google.subject" = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "gha" {
  project = local.project
  account_id = "gha-deployer"
  display_name = "gha"
}

resource "google_service_account_iam_binding" "gha_id_mapping" {
  service_account_id = google_service_account.gha.name
  role = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gha.name}/attribute.repository/crewpicker/crewpicker",
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gha.name}/attribute.repository/crewpicker/crewpicker-infra",
  ]
}

// iam member for the service account with role container.clusterViewer
resource "google_project_iam_member" "gha_cluster_viewer" {
  project = local.project
  role = "roles/container.clusterViewer"
  member = "serviceAccount:${google_service_account.gha.email}"
}

// iam member for the service account with role container.viewer
resource "google_project_iam_member" "gha_container_viewer" {
  project = local.project
  role = "roles/container.viewer"
  member = "serviceAccount:${google_service_account.gha.email}"
}
