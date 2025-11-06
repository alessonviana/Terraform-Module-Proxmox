variable "proxmox_host" {
  description = "Proxmox host address"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "proxmox_storage" {
  description = "Proxmox storage name"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Network bridge name"
  type        = string
  default     = "vmbr0"
}

variable "cloud_init_user" {
  description = "Cloud-init username"
  type        = string
  default     = "root"
}

variable "cloud_init_password" {
  description = "Cloud-init password"
  type        = string
  sensitive   = true
}

variable "dns_servers" {
  description = "DNS servers (comma-separated)"
  type        = string
  default     = "8.8.8.8,8.8.4.4"
}

variable "iso_path" {
  description = "Path to ISO image in Proxmox storage"
  type        = string
}

