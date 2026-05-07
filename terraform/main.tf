terraform {
  required_version = ">= 1.6.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

# ─── PRIVATE NETWORK ────────────────────────────────────────────────────────

resource "hcloud_network" "main" {
  name     = "${var.project_name}-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "main" {
  network_id   = hcloud_network.main.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

# ─── SSH KEY ────────────────────────────────────────────────────────────────

resource "hcloud_ssh_key" "main" {
  name       = "${var.project_name}-key"
  public_key = var.ssh_public_key
}
