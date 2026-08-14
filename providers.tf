provider "google" {
  project = var.project_id
  region  = var.region

  # Credentials should NOT be embedded in source. For CI/pipelines use one of:
  # - Set the `GOOGLE_CREDENTIALS` env var with the JSON key contents
  # - Set `GOOGLE_APPLICATION_CREDENTIALS` to the path of a service account file
  # - Use Workload Identity in GKE/Cloud Build (no key file needed)
  # The pipeline examples in README.md show recommended patterns.
}
