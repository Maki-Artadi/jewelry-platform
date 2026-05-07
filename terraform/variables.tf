variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name prefix applied to all resources"
  type        = string
  default     = "jewelry-platform"
}

variable "location" {
  description = "Hetzner datacenter location"
  type        = string
  default     = "fsn1" # Falkenstein, Germany — closest to eu-central-1
}

variable "server_type" {
  description = "Hetzner server type for all nodes"
  type        = string
  default     = "cx22" # 2 vCPU, 4GB RAM, 40GB SSD — ~€3.79/mo
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "ssh_public_key" {
  description = "SSH public key content to register with Hetzner"
  type        = string
}

variable "admin_ips" {
  description = "Your IP addresses allowed to SSH and access admin ports"
  type        = list(string)
  # Set this to your actual IP: ["x.x.x.x/32"]
  # Find your IP at: https://ipinfo.io/ip
}
