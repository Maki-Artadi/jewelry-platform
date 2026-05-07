# ─── PUBLIC IPs ─────────────────────────────────────────────────────────────

output "control_plane_public_ip" {
  description = "Floating IP of the control plane (stable, use this for DNS and SSH)"
  value       = hcloud_floating_ip.control_plane.ip_address
}

output "worker_public_ips" {
  description = "Public IPs of worker nodes"
  value       = hcloud_server.workers[*].ipv4_address
}

# ─── PRIVATE IPs (for Ansible inventory) ────────────────────────────────────

output "control_plane_private_ip" {
  description = "Private network IP of control plane"
  value       = "10.0.1.10"
}

output "worker_private_ips" {
  description = "Private network IPs of worker nodes"
  value       = [for i in range(var.worker_count) : "10.0.1.${20 + i}"]
}

# ─── SUMMARY ────────────────────────────────────────────────────────────────

output "cluster_summary" {
  description = "Quick reference for all node IPs"
  value = {
    control_plane = {
      public  = hcloud_floating_ip.control_plane.ip_address
      private = "10.0.1.10"
    }
    workers = [
      for i, w in hcloud_server.workers : {
        name    = w.name
        public  = w.ipv4_address
        private = "10.0.1.${20 + i}"
      }
    ]
  }
}
