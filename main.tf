module "vpc" {
  source      = "./modules/vpc"
  network_name = "vpc-test1"
  project_id  = var.project_id
  region      = var.region
  subnets = [
    { name = "sub-test1" , cidr = "10.0.1.0/24" },
    { name = "sub-test2" , cidr = "10.0.2.0/24" }
  ]
}

module "compute" {
  source     = "./modules/compute"
  project_id = var.project_id
  instances = [
    {
      name       = "gce-sub-test1"
      zone       = "${var.region}-a"
      subnetwork = module.vpc.subnets["sub-test1"]
    },
    {
      name       = "gce-sub-test2"
      zone       = "${var.region}-a"
      subnetwork = module.vpc.subnets["sub-test2"]
    }
  ]
}

