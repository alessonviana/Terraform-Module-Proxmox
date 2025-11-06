provider "proxmox" {
  pm_api_url          = var.proxmox_host
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_tls_insecure = true
  pm_timeout      = 600
}

module "proxmox_vms" {
  source = "github.com/alessonviana/terraform-module-proxmox?ref=main"

  proxmox_node    = "pve"
  proxmox_storage = "local-lvm"
  network_bridge  = "vmbr0"

  vms = {
    minimal-vm = {
      name      = "minimal-vm-01"
      cpu_cores = 2
      memory_mb = 2048
      disks = [{
        size = "20G"
      }]
    }
  }
}

output "vm_info" {
  value = module.proxmox_vms.vms
}

