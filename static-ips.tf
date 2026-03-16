provider "google" {
  project = local.project
}

resource "google_compute_global_address" "rmr" {
  name = "rmr"
}

resource "google_compute_global_address" "tk81" {
  name = "tk81"
}
