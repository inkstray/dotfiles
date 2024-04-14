{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

### booting related
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

### networking, locale & time
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

### services
  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      systemWide = true;
    };

    getty.autologinUser = "casey";

    openssh.enable = true;
  };

  security.polkit.enable = true;

### packages & programs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # For obsidian
  ];

  programs = {
    adb.enable = true;
    hyprland.enable = true;
    git.enable = true;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
    # Basic
      fuzzel
      kitty
      ungoogled-chromium
      pavucontrol
      home-manager
      ;
    # Qt
    inherit (pkgs.libsForQt5) qt5ct polkit-kde-agent;
    inherit (pkgs.qt6Packages) qt6ct;
  };

### users
  users.users.casey = {
    isNormalUser = true;
    description = "Casey";
    extraGroups = [
      "input"
      "networkmanager"
      "pipewire"
      "tty"
      "wheel"
      "adbusers"
    ];
    packages = builtins.attrValues {
      inherit (pkgs)
        discord
        prismlauncher
        obsidian
        aseprite
      ;
    };
  };

### environment
  qt.platformTheme = "qt5ct";

### system version
  system.stateVersion = "23.11";
}
