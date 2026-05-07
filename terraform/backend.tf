terraform {
  backend "s3" {
    bucket = "jewelry-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-central-1" # required by S3 backend, Hetzner ignores the value

    # Hetzner Object Storage endpoint (Falkenstein)
    endpoint = "https://fsn1.your-objectstorage.com"

    # Credentials — set via environment variables or GitHub Secrets:
    # AWS_ACCESS_KEY_ID     = HCLOUD_S3_ACCESS_KEY
    # AWS_SECRET_ACCESS_KEY = HCLOUD_S3_SECRET_KEY

    # Required for non-AWS S3-compatible backends
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
}
