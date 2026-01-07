# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "broadcom-sta-6.30.223.271-59-6.12.63" ];
  # imports =
  #   [ # Include the results of the hardware scan.
  #     ./hardware-configuration.nix
  #   ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Blacklist NVIDIA and Nouveau to use only Intel graphics
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];
  boot.kernelModules = [ "wl" ];  # Broadcom WiFi
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.enableB43Firmware = false;  # Use wl for BCM4331

  # Set your time zone.
  time.timeZone = "America/New_York";  # Change as needed

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "fr";
    xkb.options = "eurosign:e,caps:escape";
    videoDrivers = [ "intel" ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Graphics
  hardware.graphics.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.Badr = {
    isNormalUser = true;
    initialPassword = "rb";
    extraGroups = [ "wheel" "docker" ]; # Enable 'sudo' for the user.
    packages = with pkgs; [
      firefox
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    docker-compose
    git
    flutter
    flyctl
    # vercel
    nodejs
    # npm
    python312
    python312Packages.pip
    google-chrome
    vscode
    alacritty
    gnome-terminal
    libreoffice
    evince
    gnome-screenshot
    curl
    wget
    htop
    tmux
    fish
    openvpn
    # Additional dev tools
    gcc
    gnumake
    cmake
    pkg-config
    # Version control
    git
    # Text editors
    neovim
    # Browsers
    google-chrome
    # Terminals
    alacritty
    # Office
    libreoffice
    # Utils
    htop
    tmux
    fish
    curl
    wget
    unzip
    # Python
    python312
    python312Packages.pip
    # Node
    nodejs
    # npm
    # Flutter
    flutter
    # Deployment
    flyctl
    # vercel
    # Docker
    docker
    docker-compose
    # VPN
    openvpn
    # Screenshot
    gnome-screenshot
    # PDF
    evince
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}