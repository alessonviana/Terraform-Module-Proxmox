variable "proxmox_node" {
  description = "Proxmox node name where VMs will be created"
  type        = string
}

variable "proxmox_storage" {
  description = "Proxmox storage name for VM disks"
  type        = string
}

variable "network_bridge" {
  description = "Default network bridge name for VMs"
  type        = string
  default     = "vmbr0"
}

variable "defaults" {
  description = "Default values for VMs"
  type = object({
    cpu_cores           = optional(number, 2)
    cpu_sockets         = optional(number, 1)
    cpu_type            = optional(string, "host")
    memory_mb           = optional(number, 2048)
    bootdisk            = optional(string, "scsi0")
    iso                 = optional(string, null)
    clone               = optional(string, null)
    bios                = optional(string, "seabios")
    agent               = optional(number, 1)
    ipconfig            = optional(string, null)
    cloud_init_user     = optional(string, "root")
    cloud_init_password = optional(string, null)
    dns_servers         = optional(string, "8.8.8.8,8.8.4.4")
    searchdomain        = optional(string, "")
    ssh_keys            = optional(string, null)
    tags                = optional(string, "")
    networks = optional(list(object({
      model       = optional(string, "virtio")
      bridge      = optional(string, null)
      vlan_tag    = optional(number, null)
      mac_address = optional(string, null)
      })), [{
      model  = "virtio"
      bridge = null
    }])
    disks = optional(list(object({
      size     = string
      type     = optional(string, "scsi")
      storage  = optional(string, null)
      format   = optional(string, null)
      iothread = optional(number, null)
      ssd      = optional(number, null)
      discard  = optional(string, null)
      cache    = optional(string, null)
    })), null)
  })
  default = {}
}

variable "vms" {
  description = "Map of VMs to create"
  type = map(object({
    name                = string
    vmid                = optional(number, null)
    description         = optional(string, null)
    cpu_cores           = optional(number, null)
    cpu_sockets         = optional(number, null)
    cpu_type            = optional(string, null)
    memory_mb           = optional(number, null)
    bootdisk            = optional(string, null)
    iso                 = optional(string, null)
    clone               = optional(string, null)
    bios                = optional(string, null)
    agent               = optional(number, null)
    ipconfig            = optional(string, null)
    cloud_init_user     = optional(string, null)
    cloud_init_password = optional(string, null)
    dns_servers         = optional(string, null)
    searchdomain        = optional(string, null)
    ssh_keys            = optional(string, null)
    tags                = optional(string, null)
    networks = optional(list(object({
      model       = optional(string, null)
      bridge      = optional(string, null)
      vlan_tag    = optional(number, null)
      mac_address = optional(string, null)
    })), null)
    disks = optional(list(object({
      size     = string
      type     = optional(string, null)
      storage  = optional(string, null)
      format   = optional(string, null)
      iothread = optional(number, null)
      ssd      = optional(number, null)
      discard  = optional(string, null)
      cache    = optional(string, null)
    })), null)
  }))
}

