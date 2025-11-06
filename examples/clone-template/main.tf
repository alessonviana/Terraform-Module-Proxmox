provider "proxmox" {
  pm_api_url          = var.proxmox_host
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_tls_insecure = true
  pm_timeout      = 600
}

module "proxmox_vms" {
  source = "github.com/alessonviana/terraform-module-proxmox?ref=main"

  proxmox_node    = var.proxmox_node
  proxmox_storage = var.proxmox_storage
  network_bridge  = var.network_bridge

  defaults = {
    cpu_cores = 2
    memory_mb = 2048
    clone     = var.template_name
    networks = [{
      model  = "virtio"
      bridge = var.network_bridge
    }]
  }

  vms = {
    cloned-vm-01 = {
      name        = "cloned-vm-01"
      vmid        = 100
      description = "VM cloned from template"
      ipconfig    = "ip=192.168.1.20/24,gw=192.168.1.1"
      tags        = "cloned,test"
    }

    cloned-vm-02 = {
      name        = "cloned-vm-02"
      vmid        = 101
      description = "Another cloned VM"
      ipconfig    = "ip=192.168.1.21/24,gw=192.168.1.1"
      tags        = "cloned,test"
    }
  }
}

output "vms" {
  value = module.proxmox_vms.vms
}

