resource "google_artifact_registry_repository" "crewpicker" {
  project = local.project
  repository_id = "crewpicker"
  location      = "europe-north1"
  format        = "DOCKER"
  description   = "Crewpicker Docker images"
  labels = {
    "project" = "crewpicker"
  }
}
