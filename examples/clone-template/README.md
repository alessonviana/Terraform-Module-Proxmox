# Clone Template Example

This example demonstrates how to clone VMs from an existing Proxmox template instead of booting from ISO.

## What This Example Creates

- **cloned-vm-01**: VM cloned from template with static IP 192.168.1.20
- **cloned-vm-02**: VM cloned from template with static IP 192.168.1.21

## Prerequisites

- A VM template must exist in your Proxmox cluster
- The template should be configured and ready for cloning

## Usage

1. Copy this example to your workspace
2. Update `variables.tf` or create `terraform.tfvars` with your Proxmox credentials and template name
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

## Notes

- The `clone` parameter in defaults will be applied to all VMs
- Individual VMs can override this if needed
- Cloning is typically faster than booting from ISO for similar VMs

