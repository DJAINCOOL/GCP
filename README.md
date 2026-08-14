Terraform scaffold for GCP (terraform-gcp)

Quick start:

1. Edit `backend.tf` to set your GCS state bucket, or run:

```bash
terraform init -backend-config="bucket=YOUR_STATE_BUCKET" -backend-config="prefix=terraform/state"
```

2. Set project and credentials via environment or `terraform.tfvars`:

```hcl
project_id = "terraform-gcp"
region     = "us-west1"
credentials_file = "path/to/account.json"
```

3. Run:

```bash
terraform init
terraform validate
terraform plan
```

CI / Pipeline examples

Azure Pipelines (YAML) example snippet:

```yaml
- script: |
    echo "$(GCP_SA_KEY)" > sa.json
    export GOOGLE_APPLICATION_CREDENTIALS="$PWD/sa.json"
    terraform init -backend-config="bucket=$(STATE_BUCKET)" -backend-config="prefix=terraform/state"
    terraform validate
    terraform plan -out=tfplan
  displayName: 'Terraform Init/Plan'
  env:
    # Set GCP_SA_KEY as a secure pipeline variable containing the JSON key
    # Set STATE_BUCKET as the backend bucket name
    GCP_SA_KEY: $(GCP_SA_KEY)
```

GitHub Actions (workflow) example snippet:

```yaml
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup credentials
        run: |
          echo "${{ secrets.GCP_SA_KEY }}" > sa.json
          echo "SA file written"
        env:
          GCP_SA_KEY: ${{ secrets.GCP_SA_KEY }}
      - name: Terraform Init
        run: |
          export GOOGLE_APPLICATION_CREDENTIALS="${{ github.workspace }}/sa.json"
          terraform init -backend-config="bucket=${{ secrets.STATE_BUCKET }}" -backend-config="prefix=terraform/state"
          terraform validate
          terraform plan -out=tfplan
```

Secrets guidance:
- Store the service account JSON in a secure pipeline secret (e.g., `GCP_SA_KEY`).
- Store the state bucket name in a pipeline secret or variable (e.g., `STATE_BUCKET`).

Permissions needed for the state bucket:
- `roles/storage.objectAdmin` on the state bucket (or a narrowly scoped set of permissions).
