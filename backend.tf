terraform {
  # Leave backend block empty so pipelines can provide backend config at `terraform init`.
  # Example init in CI:
  # terraform init -backend-config="bucket=MY_STATE_BUCKET" -backend-config="prefix=terraform/state"
  backend "gcs" {}
}

# Note: the service account used in CI must have permissions to read/write the GCS bucket
# (roles/storage.objectAdmin or a narrower set of permissions on the state bucket).
