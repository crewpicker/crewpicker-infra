module "autopilot" {
  source = "./modules/autopilot"

  name    = "crewpilot-1"
  project = "crewpicker"
  region  = "europe-north1"
}
