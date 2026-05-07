# ─── CONTROL PLANE ──────────────────────────────────────────────────────────

resource "hcloud_server" "control_plane" {
  name        = "${var.project_name}-control-plane"
  image       = "ubuntu-22.04"
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.main.id]

  network {
    network_id = hcloud_network.main.id
    ip         = "10.0.1.10"
  }

  firewall_ids = [hcloud_firewall.main.id]

  labels = {
    role    = "control-plane"
    project = var.project_name
  }

  depends_on = [hcloud_network_subnet.main]
}

# ─── WORKER NODES ───────────────────────────────────────────────────────────

resource "hcloud_server" "workers" {
  count       = var.worker_count
  name        = "${var.project_name}-worker-${count.index + 1}"
  image       = "ubuntu-22.04"
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.main.id]

  network {
    network_id = hcloud_network.main.id
    ip         = "10.0.1.${20 + count.index}"
  }

  firewall_ids = [hcloud_firewall.main.id]

  labels = {
    role    = "worker"
    project = var.project_name
  }

  depends_on = [hcloud_network_subnet.main]
}

# ─── FLOATING IP (stable public IP for control plane) ───────────────────────

resource "hcloud_floating_ip" "control_plane" {
  type          = "ipv4"
  home_location = var.location
  description   = "${var.project_name} control plane"
}

resource "hcloud_floating_ip_assignment" "control_plane" {
  floating_ip_id = hcloud_floating_ip.control_plane.id
  server_id      = hcloud_server.control_plane.id
}
