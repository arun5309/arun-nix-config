# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ /*config,*/ pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.xremap-flake.nixosModules.default
    ];

  services.xremap = {
    withWlroots = true;
    yamlConfig = ''
      modmap:
        - name: Make compose into an additional escape
          remap:
            Compose: Esc
        - name: Switch backspace and caps lock
          remap:
            BackSpace: CapsLock
            CapsLock: BackSpace
        - name: Workman layout
          remap:
            q: q
            w: d
            e: r
            r: w
            t: b
            y: j
            u: f
            i: u
            o: p
            p: SemiColon
            a: a
            s: s
            d: h
            f: t
            g: g
            h: y
            j: n
            k: e
            l: o
            SemiColon: i
            z: z
            x: x
            c: m
            v: c
            b: v
            n: k
            m: l
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable and configure the SDDM login manager.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.autoNumlock = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [ pkgs.libsForQt5.systemsettings ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    # variant = "workman";
  };

  # Add main user (i.e user arun) to (u)input group
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "arun" ];
  users.groups.input.members = [ "arun" ];

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ 
      pkgs.gutenprint
      pkgs.hplip 
    ];
  };

  # Enable avahi to discover services
  services.avahi = { 
    enable = true;
    nssmdns4 = true;
    openFirewall = true; 
  };

  # Enable dconf for easyeffects and possibly other uses
  programs.dconf = {
    enable = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable locate service
  services.locate = {
    enable = true;
    interval = "hourly";
    localuser = null;
    package = pkgs.plocate;
  };

  # Enable zsh so that it can be arun's default shell
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arun = {
    isNormalUser = true;
    description = "Arunachalaeshwaran V R";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      hyprland
      ntfs3g
      fuse3
    #  thunderbird
    ];
  };

  # Save current configuration (disabled as using with flakes)
  # system.copySystemConfiguration = true; # Find current configuration at /run/current-system/configuration.nix

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "12:30" ];

  # Enable flakes and other experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Global programs (in addition to zsh, plasma desktop, sddm, print server, etc declared above)

  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Use hyprlock pam
  security.pam.services.hyprlock = {};

  # Install kdeconnect
  programs.kdeconnect.enable = true;

  # Install wshowkeys (alternative to screenkey)
  programs.wshowkeys.enable = true;

  # Virtualisation and isolation related software

  virtualisation.virtualbox = {
    host = {
      enable = true;
    };
  };

  users.extraGroups.vboxusers.members = [ "arun" ];

  programs.firejail.enable = true;

  virtualisation.libvirtd = {
    enable = false; # Disabled as workaround as ceph is not building
    qemu = {
      package = pkgs.qemu_full;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  users.extraGroups.libvirtd.members = [ "arun" ];
  users.extraGroups.qemu-libvirtd.members = [ "arun" ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.extraGroups.docker.members = [ "arun" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    home-manager
    docker-compose
  ];

  # Fonts installation
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  programs.mosh = {
    enable = true;
    openFirewall = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  
  system.stateVersion = "23.11"; # Did you read the comment?
  # system.stateVersion = "unstable";
}
