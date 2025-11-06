# Cloud-init Example

This example demonstrates how to use cloud-init to configure VMs with static IPs, users, and other settings.

## What This Example Creates

- **cloud-init-vm-01**: VM with static IP 192.168.1.10
- **cloud-init-vm-02**: VM with static IP 192.168.1.11

Both VMs are configured with:
- Cloud-init disk for configuration
- Static IP addresses
- Custom cloud-init user and password
- DNS servers

## Usage

1. Copy this example to your workspace
2. Update `variables.tf` or create `terraform.tfvars` with your Proxmox credentials and ISO path
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

## Cloud-init Configuration

The example shows how to:
- Configure static IPs via `ipconfig`
- Set up cloud-init user credentials
- Configure DNS servers
- Add a cloud-init disk (required for cloud-init to work)

