module "autopilot" {
  source = "./modules/autopilot"

  name    = "crewpilot-1"
  project = local.project
  region  = "europe-north1"
}
