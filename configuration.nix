{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs = {
    hyprland.enable = true;
    git.enable = true;
  };

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

  users.users.casey = {
    isNormalUser = true;
    description = "Casey";
    extraGroups = [
      "input"
      "networkmanager"
      "pipewire"
      "tty"
      "wheel"
    ];
    packages = builtins.attrValues {
      inherit (pkgs)
        discord
        prismlauncher
        vscode-with-extensions
        obsidian
      ;

      inherit (pkgs.vscode-extensions.catppuccin)
	catppuccin-vsc
	catppuccin-vsc-icons
      ;
    };
  };

  nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  qt.platformTheme = "qt5ct";

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
    # base
      fuzzel
      kitty
      ungoogled-chromium
      pavucontrol
      ;
    # Qt stuff
    inherit (pkgs.libsForQt5) qt5ct polkit-kde-agent;
    inherit (pkgs.qt6Packages) qt6ct;
  };

  system.stateVersion = "23.11";
}
