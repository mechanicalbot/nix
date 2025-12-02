# NixOS Flake Configuration

This repository contains NixOS flake configurations for managing multiple hosts in a homelab environment.

## Hosts

- **nix-0**: New host configuration with disk management via disko
- **nix-deploy**: Deployment/management host configuration

## Bootstrap nix-0

There are two ways to bootstrap the `nix-0` host:

### Method 1: Remote Installation (Recommended)

From an existing NixOS host, you can remotely install to a machine booted from a livecd.

**On the target machine (livecd):**
```sh
passwd  # Set root password
ip a    # Note the IP address
```

**On the source machine:**
```sh
nix run github:nix-community/nixos-anywhere -- \
  --flake .#nix-0 \
  --target-host nixos@<TARGET_IP>
```

Replace `<TARGET_IP>` with the IP address from the target machine.

### Method 2: Manual Installation

Boot the target machine from a livecd and run:

```sh
# Partition and format disk using disko
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake github:mechanicalbot-homelab/nix#nix-0

# Install NixOS
sudo nixos-install --flake github:mechanicalbot-homelab/nix#nix-0

# After reboot, clone the repo and link the flake
git clone <repo-url> /path/to/repo
cd /path/to/repo
sudo ln -s $(realpath ./flake.nix) /etc/nixos/flake.nix
```

## Managing Configurations

### Apply Configuration Locally

```sh
sudo nixos-rebuild switch --flake .#<hostname>
```

### Apply Configuration Remotely

```sh
nixos-rebuild switch --flake .#<hostname> --target-host <user>@<host>
```

### Update Flake Inputs

```sh
nix flake update
```

### Update remote host

```sh
nix run github:serokell/deploy-rs
```

### Format

```sh
nix fmt
```
