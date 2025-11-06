# Examples

This directory contains example configurations demonstrating different ways to use the Proxmox Terraform module.

## Available Examples

### [complete](./complete/)

Complete example with multiple VMs, custom configurations, multiple disks, and cloud-init. Best for understanding the full capabilities of the module.

**Key Features:**
- Multiple VMs with different configurations
- Custom CPU, memory, and disk settings
- Cloud-init with static IPs
- Multiple disks per VM
- Tags for organization

### [minimal](./minimal/)

Simplest possible example. Creates a single VM with minimal configuration. Perfect for quick testing or understanding the basics.

**Key Features:**
- Single VM
- Minimal configuration
- Uses module defaults

### [cloud-init](./cloud-init/)

Example focused on cloud-init configuration. Shows how to configure static IPs, users, and DNS.

**Key Features:**
- Cloud-init disk configuration
- Static IP addresses
- User credentials
- DNS configuration

### [clone-template](./clone-template/)

Example demonstrating how to clone VMs from existing Proxmox templates instead of booting from ISO.

**Key Features:**
- Cloning from templates
- Multiple cloned VMs
- Cloud-init configuration

## Using Examples

1. Choose an example that matches your use case
2. Copy the example directory to your workspace
3. Update variables with your Proxmox credentials
4. Run `terraform init`, `terraform plan`, and `terraform apply`

## Module Source

All examples use the module from GitHub:

```hcl
source = "github.com/alessonviana/terraform-module-proxmox?ref=main"
```

For local development, you can change this to:

```hcl
source = "../../"
```

Or use a specific version:

```hcl
source = "github.com/alessonviana/terraform-module-proxmox?ref=v1.0.0"
```

## Contributing

If you have a useful example configuration, please consider contributing it to this directory!

