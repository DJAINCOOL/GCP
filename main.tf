module "vpc" {
  source       = "./modules/vpc"
  network_name = "vpc-test1"
  project_id   = var.project_id
  region       = var.region

  subnets = [
    { name = "sub-test1", cidr = "10.0.1.0/24" },
    { name = "sub-test2", cidr = "10.0.2.0/24" }
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

variable "bigquery_dataset_permissions" {
  description = "IAM permissions for BigQuery datasets."
  type = map(object({
    project    = string
    dataset_id = string
    role       = string
    member     = string
  }))
  default = {}
}

variable "bigquery_table_permissions" {
  description = "IAM permissions for BigQuery tables."
  type = map(object({
    project    = string
    dataset_id = string
    table_id   = string
    role       = string
    member     = string
  }))
  default = {}
}

variable "bigquery_view_permissions" {
  description = "IAM permissions for BigQuery views."
  type = map(object({
    project    = string
    dataset_id = string
    view_id    = string
    role       = string
    member     = string
  }))
  default = {}
}

resource "google_bigquery_dataset_iam_member" "dataset" {
  for_each = var.bigquery_dataset_permissions

  project    = each.value.project
  dataset_id = each.value.dataset_id
  role       = each.value.role
  member     = each.value.member
}

resource "google_bigquery_table_iam_member" "table" {
  for_each = var.bigquery_table_permissions

  project    = each.value.project
  dataset_id = each.value.dataset_id
  table_id   = each.value.table_id
  role       = each.value.role
  member     = each.value.member
}

resource "google_bigquery_table_iam_member" "view" {
  for_each = var.bigquery_view_permissions

  project    = each.value.project
  dataset_id = each.value.dataset_id
  table_id   = each.value.view_id
  role       = each.value.role
  member     = each.value.member
}

