resource "proxmox_vm_qemu" "vm" {
  for_each = var.vms

  name        = each.value.name
  target_node = var.proxmox_node
  vmid        = each.value.vmid != null ? each.value.vmid : null
  desc        = each.value.description != null ? each.value.description : ""

  # CPU configuration
  cores   = coalesce(each.value.cpu_cores, try(var.defaults.cpu_cores, 2))
  sockets = coalesce(each.value.cpu_sockets, try(var.defaults.cpu_sockets, 1))
  cpu     = coalesce(each.value.cpu_type, try(var.defaults.cpu_type, "host"))

  # Memory configuration
  memory = coalesce(each.value.memory_mb, try(var.defaults.memory_mb, 2048))

  # Network configuration
  dynamic "network" {
    for_each = coalesce(
      each.value.networks,
      try(var.defaults.networks, null),
      [{
        model  = "virtio"
        bridge = var.network_bridge
      }]
    )
    content {
      model   = coalesce(network.value.model, "virtio")
      bridge  = coalesce(network.value.bridge, var.network_bridge)
      tag     = network.value.vlan_tag
      macaddr = network.value.mac_address
    }
  }

  # Disk configuration
  dynamic "disk" {
    for_each = coalesce(
      each.value.disks,
      try(var.defaults.disks, null),
      [{
        size    = "20G"
        type    = "scsi"
        storage = var.proxmox_storage
      }]
    )
    content {
      size     = disk.value.size
      type     = coalesce(disk.value.type, "scsi")
      storage  = coalesce(disk.value.storage, var.proxmox_storage)
      format   = disk.value.format
      iothread = disk.value.iothread
      ssd      = disk.value.ssd
      discard  = disk.value.discard
      cache    = disk.value.cache
    }
  }

  # Boot configuration
  bootdisk = coalesce(each.value.bootdisk, try(var.defaults.bootdisk, "scsi0"))
  iso      = coalesce(each.value.iso, try(var.defaults.iso, null))
  clone    = coalesce(each.value.clone, try(var.defaults.clone, null))

  # BIOS/UEFI
  bios = coalesce(each.value.bios, try(var.defaults.bios, "seabios"))

  # QEMU agent
  agent = coalesce(each.value.agent, try(var.defaults.agent, 1))

  # Cloud-init configuration
  ipconfig0    = coalesce(each.value.ipconfig, try(var.defaults.ipconfig, null))
  ciuser       = coalesce(each.value.cloud_init_user, try(var.defaults.cloud_init_user, "root"))
  cipassword   = coalesce(each.value.cloud_init_password, try(var.defaults.cloud_init_password, null))
  nameserver   = coalesce(each.value.dns_servers, try(var.defaults.dns_servers, "8.8.8.8,8.8.4.4"))
  searchdomain = coalesce(each.value.searchdomain, try(var.defaults.searchdomain, ""))
  sshkeys      = coalesce(each.value.ssh_keys, try(var.defaults.ssh_keys, null))

  # Tags
  tags = coalesce(each.value.tags, try(var.defaults.tags, ""))

  # Lifecycle
  lifecycle {
    ignore_changes = [
      network,
      disk,
      ipconfig0,
    ]
  }
}

