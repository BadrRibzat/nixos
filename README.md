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

## Step-by-Step NixOS Installation Guide for MacBook Pro 9,1
Preparation
1. Burn the ISO to a USB drive (on your current Linux Mint system):

# Assuming your USB is /dev/sdb (check with lsblk first!)
sudo dd if=/home/badr/nixos-minimal-26.05.20260105.9f0c42f-x86_64-linux.iso of=/dev/sdb bs=4M status=progress

2. Boot from USB: Insert the USB into your MacBook Pro, restart, and hold Option key to select the EFI boot menu. Choose the USB drive.

Live Session Setup
3. Connect to WiFi (Broadcom should work):

Click the network icon in the top-right
Select your WiFi network and enter password
Open a terminal (Alacritty should be available)

4. Download the configuration:
git clone https://github.com/yourusername/nixos.git  # Replace with your actual repo URL
cd nixos

Disk Partitioning and Formatting

5. Identify your disk:
lsblk  # Should show /dev/sda as your main disk

6. Wipe and partition the disk (this will erase everything):
# Use parted for GPT partitioning
sudo parted /dev/sda -- mklabel gpt
sudo parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sda -- set 1 esp on
sudo parted /dev/sda -- mkpart primary ext4 512MiB 100%

7. Format the partitions:
sudo mkfs.fat -F 32 /dev/sda1
sudo mkfs.ext4 /dev/sda2

Installation
8. Mount the partitions:
sudo mount /dev/sda2 /mnt
sudo mkdir /mnt/boot
sudo mount /dev/sda1 /mnt/boot

9. Generate NixOS configuration:
sudo nixos-generate-config --root /mnt

10. Copy your custom configuration:
sudo cp configuration.nix /mnt/etc/nixos/configuration.nix

11. Install NixOS:
sudo nixos-install

This will take some time. It will download and install all packages.
12. Set root password (optional, since user has initial password):
sudo nixos-enter --root /mnt -- passwd

Final Steps

13. Unmount and reboot:
sudo umount -R /mnt
sudo reboot

14. Remove USB and boot into your new NixOS system.

Post-Installation
Login as user "Badr" with password "rb"
GNOME desktop should start with French keyboard
All your tools (Neovim, Docker, etc.) should be installed
The system uses 8GiB zram swap as configured
WiFi should work with Broadcom drivers
Troubleshooting
If display issues occur, the Intel graphics should work stably
If WiFi doesn't connect, check dmesg | grep wl for Broadcom module loading
For any issues, you can chroot back: sudo nixos-enter --root /mnt
This should give you a fully functional NixOS system on your MacBook Pro! Let me know if you encounter any issues during the process.


