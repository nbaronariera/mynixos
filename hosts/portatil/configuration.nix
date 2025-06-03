# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules/default.nix
  ];

  ########################################
  # ACTIVACIÓN DE MÓDULOS PERSONALIZADOS #
  ########################################
  my.enableSteam = true;
  my.enableDiscord = true;
  my.enableGit = true;
  my.enableNixfmt = true;
  my.enableKVM = true;
  my.enableCachix = true;
  my.enableHyprlandModule = true;
  my.enableHeroic = true;
  my.enableRust = true;
  my.enablePython = true;
  my.enableKrita = true;
  my.enableVSCode = true;
  my.enableDocker = true;
  my.enableJS = true;
  my.enableJava = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "portatil"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "winkeys";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  #services.printing = {
  #  enable = true;
  #  drivers = [ pkgs.hplipWithPlugin ];
  #};

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  security = {
    polkit.enable = true;
    pam.services.hyprlock = { };
    rtkit.enable = true;
  };

  hardware.keyboard.qmk.enable = true;

  services.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
    #manager = "wireplumber";

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  system.autoUpgrade = {
    enable = true;
    persistent = true;
    dates = "daily";
    flake = "/home/nbr/Documentos/NixOs-Conf/";
    operation = "switch";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "home-manager"
      "--update-input"
      "hyprland"
      "--update-input"
      "flale-utils"
      "--commit-lock-file"
      "--impure"
    ];
  };

  nix.gc = {
    automatic = true;
    persistent = false;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nbr = {
    isNormalUser = true;
    description = "Nicolas Barona Riera";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.dolphin
      fira-code
      via
      google-chrome
      qmk
      jetbrains.idea-ultimate
      siyuan
      cmatrix
      lld
      sxiv
      obsidian
      ripgrep
    ];
  };

  users.users.luca = {
    isNormalUser = true;
    description = "Luca Lucae";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.dolphin
      fira-code
    ];
  };

  fonts.fontDir.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Fira Code" ];
      serif = [ "Fira Code" ];
      monospace = [ "Fira Code" ];
    };
  };

  programs.dconf.enable = true;

  # Configuraciones de SDDM
  services.displayManager.sddm.enable = true;

  # Configuraciones de Plasma
  services.desktopManager.plasma6.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fixes ld problems
  programs.nix-ld.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    wget
    pass-wayland
    home-manager
    gnupg
    pinentry-curses
    wireplumber
    btop
    pavucontrol
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    kdePackages.xdg-desktop-portal-kde
    xdg-desktop-portal-wlr
    mesa
    vulkan-loader
    vulkan-tools
    neofetch
    jq
    nh
    gnum4
    m4ri
    gnumake
    blueman
    unrar
    zip
    brightnessctl
    wlsunset
    openssl
    haruna
    jdt-language-server
    wl-clipboard
    onlyoffice-desktopeditors
    onlyoffice-documentserver
    gnome-calculator
    mpv
    feh
    imv
    tldr
    syncthing
    powertop
    tlp # Opción más agresiva de ahorro de energía
    powertop2tuned
  ];

  programs.zsh.enable = true;
  users.users.nbr.shell = pkgs.zsh;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;
  #services.openssh.passwordAuthentication = false;
  #services.openssh.permitRootLogin = "prohibit-password";

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
