# Terraform Module - Proxmox

This Terraform module provides a flexible and reusable interface to create and manage VMs in Proxmox.

## Features

- **Flexible**: Supports multiple VMs with individual configurations
- **Dynamic**: Allows override of default values per VM
- **Reusable**: Can be used for different types of deployments
- **Cloud-init**: Full support for configuration via cloud-init
- **Multiple Disks**: Support for multiple disks and network configurations
- **Clone Support**: Boot from ISO or clone from templates

## Usage

### Using from GitHub

```hcl
module "proxmox_vms" {
  source = "github.com/alessonviana/terraform-module-proxmox"

  proxmox_node   = "pve"
  proxmox_storage = "local-lvm"
  network_bridge = "vmbr0"

  defaults = {
    cpu_cores = 2
    memory_mb = 2048
    disks = [{
      size = "20G"
      type = "scsi"
    }]
  }

  vms = {
    vm1 = {
      name      = "my-vm-01"
      vmid      = 100
      cpu_cores = 4
      memory_mb = 4096
      ipconfig  = "ip=192.168.1.10/24,gw=192.168.1.1"
      disks = [{
        size = "50G"
        type = "scsi"
      }]
    }
  }
}
```

### Using a Specific Version

```hcl
module "proxmox_vms" {
  source = "github.com/alessonviana/terraform-module-proxmox?ref=v1.0.0"
  
  # ... rest of configuration
}
```

### Using from Local Path (Development)

```hcl
module "proxmox_vms" {
  source = "../../modulo-proxmox"
  
  # ... rest of configuration
}
```

## Requirements

- Terraform >= 1.0
- Proxmox Provider (Telmate/proxmox ~> 3.0)
- Access to Proxmox via API

## Variables

### Main Variables

- `proxmox_node` (required): Proxmox node name where VMs will be created
- `proxmox_storage` (required): Proxmox storage name for VM disks
- `network_bridge` (optional): Default network bridge (default: "vmbr0")
- `defaults` (optional): Default values for all VMs
- `vms` (required): Map of VMs to create

### VM Configuration

Each VM in the `vms` map can have the following properties:

- `name` (required): VM name
- `vmid` (optional): VM ID (automatically generated if not specified)
- `description` (optional): VM description
- `cpu_cores`, `cpu_sockets`, `cpu_type`: CPU configuration
- `memory_mb`: Memory in MB
- `networks`: List of network interfaces
- `disks`: List of disks
- `iso`, `clone`: Boot from ISO or clone from template
- `ipconfig`: Static IP configuration (cloud-init format: `ip=X.X.X.X/XX,gw=X.X.X.X`)
- `cloud_init_user`, `cloud_init_password`: Cloud-init credentials
- `dns_servers`: DNS servers (comma-separated)
- `searchdomain`: Search domain for DNS
- `ssh_keys`: SSH public keys (newline-separated)
- `tags`: Tags for organization (comma-separated)

## Outputs

- `vms`: Complete information about all created VMs (id, name, ip_address, mac_address)
- `vm_ids`: Map of VM names to VM IDs
- `vm_names`: List of VM names

## Examples

Complete working examples are available in the [`examples`](./examples/) directory:

- **[complete](./examples/complete/)**: Full example with multiple VMs, custom configurations, and cloud-init
- **[minimal](./examples/minimal/)**: Simplest possible example with a single VM
- **[cloud-init](./examples/cloud-init/)**: Example focused on cloud-init configuration
- **[clone-template](./examples/clone-template/)**: Example demonstrating template cloning

See the [examples README](./examples/README.md) for more details.

## Provider Configuration

This module requires the Proxmox provider to be configured. Example:

```hcl
provider "proxmox" {
  pm_api_url          = "https://your-proxmox:8006/api2/json"
  pm_api_token_id     = "your-token-id@pam!terraform"
  pm_api_token_secret = "your-token-secret"

  pm_tls_insecure = true
  pm_timeout      = 600
}
```

## Repository

This module is available at:
- GitHub (HTTPS): `https://github.com/alessonviana/terraform-module-proxmox.git`

## Versioning

This module follows semantic versioning. When using from GitHub, you can pin to a specific version:

```hcl
source = "github.com/alessonviana/terraform-module-proxmox?ref=v1.0.0"
```

Or use the latest version from a branch:

```hcl
source = "github.com/alessonviana/terraform-module-proxmox?ref=main"
```

## Contributing

Contributions are welcome and greatly appreciated! This project is open to community involvement and we encourage you to participate.

### How to Contribute

#### Reporting Bugs

If you've found a bug or issue with the module:

1. **Check existing issues**: Before creating a new issue, please check if the problem has already been reported in the [Issues](https://github.com/alessonviana/terraform-module-proxmox/issues) section
2. **Create a new issue**: If it's a new issue, please provide:
   - A clear and descriptive title
   - Steps to reproduce the issue
   - Expected behavior vs actual behavior
   - Terraform version and Proxmox version
   - Relevant error messages or logs
   - Your module configuration (sanitize sensitive information)

#### Requesting Features

Have an idea for a new feature or improvement?

1. **Open an issue**: Create a feature request issue describing:
   - The feature or enhancement you'd like to see
   - Use case or problem it would solve
   - Any relevant examples or references

2. **Discussion**: We'll discuss the feature and determine the best approach

#### Submitting Code Changes

We welcome code contributions through Pull Requests (PRs) or Merge Requests (MRs):

1. **Fork the repository**: Create your own fork of the repository
2. **Create a branch**: Create a feature branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**: Implement your changes following the existing code style
4. **Test your changes**: Ensure your changes work correctly and don't break existing functionality
5. **Update documentation**: If your changes affect the module's interface or behavior, update the README accordingly
6. **Commit your changes**: Write clear, descriptive commit messages:
   ```bash
   git commit -m "Add feature: description of your changes"
   ```
7. **Push to your fork**: Push your branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
8. **Open a Pull Request or Merge Request**: Create a PR/MR from your fork to the main repository:
   - Provide a clear description of what the PR/MR does
   - Reference any related issues
   - Include examples of how to use new features if applicable

### Code Style Guidelines

- Follow existing code formatting (use `terraform fmt`)
- Write clear, descriptive variable and resource names
- Add comments for complex logic
- Keep functions focused and single-purpose
- Update documentation for any API changes

### Example Contributions

Great contributions include:
- Bug fixes
- New features and enhancements
- Documentation improvements
- Additional examples in the `examples/` directory
- Performance optimizations
- Test coverage improvements

### Questions?

If you have questions about contributing or need help getting started, feel free to:
- Open a discussion issue
- Reach out through the repository

Thank you for contributing to this project! 🎉
