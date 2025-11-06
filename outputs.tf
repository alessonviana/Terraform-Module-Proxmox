output "vms" {
  description = "Information about all created VMs"
  value = {
    for k, vm in proxmox_vm_qemu.vm : k => {
      id          = vm.vmid
      name        = vm.name
      ip_address  = vm.default_ipv4_address
      mac_address = length(vm.network) > 0 ? try(vm.network[0].mac, "N/A") : "N/A"
    }
  }
}

output "vm_ids" {
  description = "Map of VM names to VM IDs"
  value = {
    for k, vm in proxmox_vm_qemu.vm : k => vm.vmid
  }
}

output "vm_names" {
  description = "List of VM names"
  value       = [for vm in proxmox_vm_qemu.vm : vm.name]
}

