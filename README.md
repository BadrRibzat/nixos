# NixOS Configuration for MacBook Pro 9,1

This repository contains a custom NixOS configuration and ISO build for the MacBook Pro 9,1 (Mid 2012) laptop.

## Features

- **Graphics**: Intel HD Graphics 4000 only (NVIDIA disabled to avoid issues)
- **WiFi**: Broadcom BCM4331 support for internet access in live session
- **Desktop**: GNOME with French keyboard layout
- **User**: Badr with initial password 'rb'
- **Tools**: Neovim, Docker, Git, Flutter, Node.js, Python 3.12, Chrome, VS Code, Alacritty terminal, LibreOffice, and more

## Building the ISO

1. Install Nix with flakes enabled:
   ```bash
   curl -L https://nixos.org/nix/install | sh
   . /home/badr/.nix-profile/etc/profile.d/nix.sh
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

2. Clone and build:
   ```bash
   git clone <this-repo>
   cd nixos
   nix build .#nixosConfigurations.iso.config.system.build.isoImage
   ```

3. The ISO will be at `result/iso/nixos-*.iso`

## Installation

Boot from the ISO, connect to WiFi (Broadcom should work), and install NixOS using the provided configuration.

Copy the `configuration.nix` to `/mnt/etc/nixos/configuration.nix` during installation.

## Notes

- Broadcom WiFi uses the insecure `broadcom-sta` driver due to hardware limitations.
- NVIDIA is blacklisted to ensure stable Intel-only graphics.
