resource "google_container_cluster" "primary" {
  name      = var.name
  location  = var.region
  project   = var.project

  enable_autopilot = true
  # https://github.com/hashicorp/terraform-provider-google/issues/10782
  ip_allocation_policy {
  }
}
