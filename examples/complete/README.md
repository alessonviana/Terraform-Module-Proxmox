# Complete Example

This example demonstrates a complete configuration using the Proxmox module with multiple VMs, custom configurations, and cloud-init.

## What This Example Creates

- **web-server-01**: Web server VM with 4 CPUs, 4GB RAM, and 2 disks (50GB + 100GB)
- **db-server-01**: Database server VM with 8 CPUs, 8GB RAM, and 1 disk (200GB)

Both VMs are configured with:
- Static IPs via cloud-init
- Custom tags for organization
- Multiple disks

## Usage

1. Copy this example to your workspace
2. Update `variables.tf` or create `terraform.tfvars` with your Proxmox credentials
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

## Variables

See `variables.tf` for required and optional variables.

