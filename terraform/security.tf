resource "hcloud_firewall" "main" {
  name = "${var.project_name}-firewall"

  # ─── INBOUND ──────────────────────────────────────────────────────────────

  # SSH — your IP only
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.admin_ips
  }

  # Kubernetes API server — your IP only
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6443"
    source_ips = var.admin_ips
  }

  # HTTP — public (store traffic)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # HTTPS — public (TLS via cert-manager)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # n8n UI — your IP only
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "8080"
    source_ips = var.admin_ips
  }

  # Uptime Kuma UI — your IP only
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "3001"
    source_ips = var.admin_ips
  }

  # Grafana — your IP only
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "3000"
    source_ips = var.admin_ips
  }

  # NodePort range — your IP only (for kubectl port-forward / direct testing)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "30000-32767"
    source_ips = var.admin_ips
  }

  # ICMP (ping) — useful for debugging
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # ─── INTERNAL NODE-TO-NODE (private network) ──────────────────────────────
  # Hetzner private networks are isolated by default — no firewall rule needed.
  # All 10.0.1.0/24 traffic is unrestricted within the network.
}
