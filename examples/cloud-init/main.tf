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
    cpu_cores           = 2
    memory_mb           = 2048
    cloud_init_user     = var.cloud_init_user
    cloud_init_password = var.cloud_init_password
    dns_servers         = var.dns_servers
    networks = [{
      model  = "virtio"
      bridge = var.network_bridge
    }]
    disks = [{
      size = "20G"
      type = "scsi"
      }, {
      # Cloud-init disk
      size   = "4M"
      type   = "virtio"
      format = "raw"
    }]
  }

  vms = {
    vm-01 = {
      name     = "cloud-init-vm-01"
      vmid     = 100
      ipconfig = "ip=192.168.1.10/24,gw=192.168.1.1"
      iso      = var.iso_path
    }

    vm-02 = {
      name     = "cloud-init-vm-02"
      vmid     = 101
      ipconfig = "ip=192.168.1.11/24,gw=192.168.1.1"
      iso      = var.iso_path
    }
  }
}

output "vms" {
  value = module.proxmox_vms.vms
}

