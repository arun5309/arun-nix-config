{ config, pkgs, lib, system, allowed-unfree-packages, colorSchemeMode, colorSchemeString, colorSchemeAccent, fzf_color_scheme, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "arun";
  home.homeDirectory = "/home/arun";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    file
    ncdu
    buku
    fastfetch
    unixtools.xxd
    usbutils
    psmisc
    ffmpeg-full
    imagemagick
    w3m
    autossh
    loccount
    rlwrap
    pdftk
    pdfsandwich
    espeak
    livecaptions
    alsa-utils
    graphviz
    tikzit
    qtikz
    # svg2tikz
    inkscape-with-extensions
    ctpv
    pavucontrol
    stirling-pdf
    pdf4qt
    xournalpp
    krita
    krita-plugin-gmic
    scribus
    kdePackages.kdenlive
    # gimp-with-plugins
    glaxnimate
    # opentoonz # Workaround as having security issue
    synfigstudio
    # qstopmotion # Not needed for now
    # linuxstopmotion # Not needed for now
    darktable
    kdePackages.zanshin
    tenacity
#     ardour
    zynaddsubfx
    odin2
    surge
    surge-XT
    fluidsynth
    # helm
    # oxefmsynth # Workaround as causing build issues
    # fmsynth # Workaround as one of its dependencies is not building
    geonkick
    calf
    talentedhack
    # x42-plugins # Workaround as the package has hash collisions
    lsp-plugins
    tap-plugins
    zam-plugins
    # infamousPlugins # Workaround as one of its dependencies is not building
    caps
    noise-repellent
    speech-denoiser
    eq10q
    vamp-plugin-sdk
    ladspaPlugins
    lv2
    metersLv2
    # carla
    # sonic-visualiser
    # sonic-lineup
    # tony
    vlc
    qbittorrent
    brave
    wgcf
    wireguard-tools
    lm_sensors
    libnotify
    wayland-pipewire-idle-inhibit
    wl-clipboard
    wl-clip-persist
    wlogout
    wvkbd
    light
    avizo
    wlr-randr
    wayout
    wlrctl
    wev
    wayland-utils
    wlr-protocols
    # hyprland-protocols # Disabling as it conflicts with hyprland uwsm
    p7zip-rar
    # inputs.hyprlock.packages.${pkgs.system}.hyprlock
    # inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    # inputs.hyprpaper.packages.${pkgs.system}.hyprpaper
    # inputs.hypridle.packages.${pkgs.system}.hypridle
    # inputs.xdg-desktop-portal-hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    hyprlock
    hyprpicker
    hyprpaper
    hypridle
    xdg-desktop-portal-hyprland
    kdePackages.dolphin-plugins
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-admin
    kdePackages.kio-extras
    kdePackages.kio-zeroconf
    kdePackages.svgpart
    kdePackages.ksvg
    kdePackages.markdownpart
    kdePackages.kparts
    kdePackages.kpackage
    kdePackages.krdc
    kdePackages.krdp
    kdePackages.krfb
    freerdp3
    cage
    waypipe
    # wayvnc
    satty
    grim
    slurp
    kdePackages.wayland-protocols
    kdePackages.plasma-wayland-protocols
    kdePackages.skanpage
    kdePackages.filelight
    kdePackages.kfind
    kdePackages.kdenetwork-filesharing
    kdePackages.kdeplasma-addons
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.knewstuff
    kdePackages.kcmutils
    kdePackages.kscreen
    kdePackages.kirigami-addons
    kdePackages.kirigami
    kdePackages.kquickimageedit
    kdePackages.kquickcharts
    librecad
    # freecad # Workaround as one of its dependencies is broken
    # blender
    # natron # Workaround as one of its dependencies is broken
    libresprite
    pixelorama
    ldtk
    tiled
    texliveFull
    texlivePackages.svg-inkscape
    hunspell
    hunspellDicts.en_US-large
    vale
    libreoffice-qt-fresh
    pdftk
    pdf4qt
    pdfsandwich
    devbox
    man-pages
    tldr
    #binutils-unwrapped-all-targets
    pkg-config
    automake
    autoconf
    gnum4
    gdb
    gef
    meson
    cmakeCurses
    gnumake
    ninja
    bear
    ltrace
    go
    gopls
    marksman
    dockerfile-language-server-nodejs
    docker-compose-language-service
    mold
    ccache
    valgrind
    perf-tools
    rr
    gdbgui
    seer
    kdePackages.kcachegrind
    hotspot
    radare2
    iaito
    pv
    just
    earthly
    tcpdump
    nmap
    inetutils
    sysstat
    reptyr
    iotop
    openconnect
    lksctp-tools
    nil
    nixfmt-rfc-style
    hardinfo2
    inxi
    zfs
    # Libraries
    gmp
    gmpxx
    openssl
    boost
    gcc
    # Explicitly versioned stuff
    #llvmPackages_20.clang-tools
    #llvmPackages_20.clang-tools-extra
    #llvmPackages_20.stdenv
    #llvmPackages_20.clangWithLibcAndBasicRtAndLibcxx
    llvmPackages_20.clang-unwrapped
    llvmPackages_20.bintools-unwrapped
    llvmPackages_20.openmp
    llvmPackages_20.libunwind
    #llvmPackages_20.libclc
    llvmPackages_20.libcxx
    lld_20
    lldb_20
    godot_4
    godot_4-export-templates-bin
    python313Full
    nodejs_24
    # Fun below
    sdlpop
    # Temporary dependencies
    python311Packages.cryptography
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/btop/themes/${lib.toLower (builtins.replaceStrings [ "-" ] [ "_" ] colorSchemeString)}.theme".text = builtins.readFile
      (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "btop";
          rev = "c646919";
          sha256 = "jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
        } + /themes/${lib.toLower (builtins.replaceStrings [ "-" ] [ "_" ] colorSchemeString)}.theme);

    ".config/lazygit/config.yml".text = builtins.readFile
      (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "lazygit";
          rev = "a544cef";
          sha256 = "gM0HplHhcpvtpmIVdlX/p59h0v+ihKEidS1imqPYlBg=";
        } + /themes/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}/${lib.toLower colorSchemeAccent}.yml);

    ".config/lf/icons".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
      sha256 = "0141nzyjr3mybkbn9p0wwv5l0d0scdc2r7pl8s1lgh11wi2l771x";
    };

    ".config/hypr/${(lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2))}.conf".text = builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "hyprland";
        rev = "fc228737d3d0c12e34a7fa155a0fc3192e5e4017";
        sha256 = "0ynyapg6nrpgm6rmwqdy6h9q063jp2z3lsph03gn2bkmsammj67l";
      } + /themes/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.conf);

    ".local/share/rofi/themes/${lib.toLower colorSchemeString}.rasi".text = builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "rofi";
        rev = "5350da41a11814f950c3354f090b90d4674a95ce";
        sha256 = "15phrl9qlbzjxmp29hak3a5k015x60w2hxjif90q82vp55zjpnhc";
      } + "/basic/.local/share/rofi/themes/${lib.toLower colorSchemeString}.rasi");

    ".config/dunst/dunstrc_themed".text = builtins.readFile (
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "dunst";
          rev = "5955cf0213d14a3494ec63580a81818b6f7caa66";
          sha256 = "1rpxrnhphcxm93s2wc7wbd9cxjmv79r2m6ip0a6rj7lh9v0ps6mc";
        } + /themes/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.conf) +
        ''
        [global]
        icon_position=off
        origin = "bottom-right"
        '';

      ".config/hypr/hypridle.conf".text = ''
        general {
          lock_cmd = hyprlock          # dbus/sysd lock command (loginctl lock-session)
          unlock_cmd = notify-send "unlock!"      # same as above, but unlock
          before_sleep_cmd = notify-send "Zzz"    # command ran before sleep
          after_sleep_cmd = notify-send "Awake!"  # command ran after sleep
          ignore_dbus_inhibit = false             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
        }

        listener {
            timeout = 500                            # in seconds
            on-timeout = hyprlock # command to run when timeout has passed
            on-resume = notify-send "Welcome back!"  # command to run when activity is detected after timeout has fired.
        }
      '';
      ".config/hypr/hyprlock.conf".text = ''
        general {
          disable_loading_bar = true
          hide_cursor = true
        }

        background {
          monitor =
          path = /home/arun/arun-nix-config/media/splash/main.png # Workaround for now
          color = rgba(0, 0, 0, 1.0)
          brightness = 0.01
        }
      '';
      ".config/hypr/hyprpaper.conf".text = ''
        preload = $HOME/arun-nix-config/media/splash/main.png
        wallpaper = HDMI-A-1, $HOME/arun-nix-config/media/splash/main.png
        wallpaper = VGA-1, $HOME/arun-nix-config/media/splash/main.png
        splash = false
      '';
      ".config/waybar/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.css".text = builtins.readFile (
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "waybar";
          rev = "f74ab1eecf2dcaf22569b396eed53b2b2fbe8aff";
          sha256 = "1bs0g32h6z6v7wkb595yddz1p7d2abxn8d7q117lxl7ncl1lrcjq";
        } + /themes/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.css);
        ".config/wlogout/layout".text = ''
            {
                "label" : "lock",
                "action" : "hyprlock",
                "text" : "Lock",
                "keybind" : "l"
            }
            {
                "label" : "hibernate",
                "action" : "systemctl hibernate",
                "text" : "Hibernate",
                "keybind" : "h"
            }
            {
                "label" : "logout",
                "action" : "hyprctl dispatch exit",
                "text" : "Logout",
                "keybind" : "e"
            }
            {
                "label" : "shutdown",
                "action" : "poweroff",
                "text" : "Shutdown",
                "keybind" : "p"
            }
            {
                "label" : "suspend",
                "action" : "systemctl suspend",
                "text" : "Suspend",
                "keybind" : "s"
            }
            {
                "label" : "reboot",
                "action" : "reboot",
                "text" : "Reboot",
                "keybind" : "r"
            }
        '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at

  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/arun/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="kde"; # Workaround as setting platform theme to KDE breaks system settings
    GTK_THEME="Breeze-Dark"; # Workaround as Breeze-Dark theme is not being set properly
    # EDITOR = "emacs";
    PAGER = "bat";
    VISUAL = "bat";
    # Audio plugin paths
    DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set default applications (i.e MIME types)
  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "kate.desktop" ];
    "application/pdf" = [ "okular.desktop" ];
    "image/*" = [ "gwenview.desktop" ];
    "video/*" = [ "vlc.desktop" ];
    "audio/*" = [ "vlc.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
  };

  # Theming and colors

  # GTK theming

  gtk = {
    enable = true;
    theme = {
      name = "Breeze"; # "${colorSchemeString}-Compact-${colorSchemeAccent}-${colorSchemeMode}";
      package = pkgs.adw-gtk3;
#       pkgs.catppuccin-gtk.override {
#         accents = [ (lib.toLower colorSchemeAccent) ];
#         size = "compact";
#         tweaks = [ "rimless" "black" ];
#         variant = lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2);
#       };
    };
    /*cursorTheme = {
      name = "${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}${colorSchemeAccent}";
      package = pkgs.catppuccin-cursors;
    };*/ # Use breeze cursor instead of gtk cursor
    iconTheme = {
      name = "Papirus-${colorSchemeMode}";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}";
        accent = lib.toLower colorSchemeAccent;
      };
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # Qt theming

  # Refer https://github.com/nix-community/home-manager/issues/5098 # Temporary workaround

  xdg.configFile."menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  systemd.user.sessionVariables = { QT_QPA_PLATFORMTHEME = "kde"; };

  qt = {
    enable = true;
    platformTheme.package = with pkgs.kdePackages; [
      plasma-integration
      systemsettings
    ];
    # Disabled below due to bug in home-manager option
    /*platformTheme = {
      name = "kde";
    };*/
    /*style = {
      name = "${colorSchemeString}-Compact-${colorSchemeAccent}-${colorSchemeMode}";
      package = pkgs.catppuccin-gtk.override {
        accents = [ (lib.toLower colorSchemeAccent) ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2);
      };
    };*/
    style = {
      name = "Breeze"; # "cat-${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}-${lib.toLower colorSchemeAccent}";
      package = pkgs.catppuccin-kde.override {
        flavour = [ "${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}" ];
        accents = [ (lib.toLower colorSchemeAccent) ];
        winDecStyles = [ "modern" ];
      };
    };
  };

  # Window manager: hyprland

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Disabling as it conflicts with uwsm
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      source = [ "~/.config/hypr/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.conf" ];
      "$mod" = "SUPER";
      env = [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];
      general = {
        allow_tearing = true;
        monitor = [ "VGA-1, 1920x1080, 1920x0, 1" "HDMI-A-1, 1920x1080, 0x0, 1" ];
        gaps_out = 0;
        gaps_in = 0;
      };
      input = {
        numlock_by_default = true;
      };
      device = {
        name = "wacom-intuos-s-pen";
        # transform = 0;
        output = "VGA-1";
      };
      misc = {
        force_default_wallpaper = 0;
        disable_splash_rendering = true;
        enable_anr_dialog = false; # Disables annoying application has stopped responding dialogue.
      };
      windowrulev2 = [
        "float,class:(waybar),title:(waybar)"
#         "noblur, class:^(Gromit-mpx)$"
#         "opacity 1 override,1 override, class:^(Gromit-mpx)$"
#         "noshadow, class:^(Gromit-mpx)$"
#         "fakefullscreen, class:^(Gromit-mpx)$"
#         "size 100% 100%, class:^(Gromit-mpx)$"
      ];
      workspace = [
        "1,monitor:HDMI-A-1,default:true"
        "2,monitor:VGA-1,default:true"
#         "special:gromit,gapsin:0,gapsout:0,on-created-empty:gromit-mpx -a"
      ];
      exec-once = [
        "hyprpaper"
        "hypridle"
        "dunst -config $HOME/.config/dunst/dunstrc_themed"
        "wl-clip-persist --clipboard both"
        "copyq --start-server"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "waybar"
        "sleep 5 && hyprctl hyprpaper unload all"
        # "hyprlock"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      bind = let monocle = "dwindle:no_gaps_when_only"; in [
        "$mod, F1, exec, killall -SIGUSR1 .waybar-wrapped"

        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, F, togglefloating"
        "$mod, F, fullscreen"
        "$mod, G, togglegroup"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit"
        "$mod, T, togglefloating"
        "$mod, P, pseudo"
        "$mod ALT, ,resizeactive,"

        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | ${pkgs.json2tsv}/bin/jaq -r '.int') ^ 1))"

        "$mod, Period, layoutmsg, cyclenext"
        "$mod, Comma, layoutmsg, swapwithmaster master"

        "$mod, Escape, exec, wlogout -p layer-shell"
        # "$mod SHIFT, L, exec, hyprlock"
        # "$mod SHIFT, O, exec, run-as-service wl-ocr"

        "$mod, Return, exec, kitty"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, VGA-1"

        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        "$mod SHIFT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod SHIFT, bracketright, movecurrentworkspacetomonitor, r"

        "$mod, D, exec, rofi -show drun"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod SHIFT, V, exec, copyq toggle"
        "$mod, Print, exec, ~/arun-nix-config/scripts/screenshot.sh"
        ", Print, exec, grim - | wl-copy"
      ] ++ (
        # Workspaces
        # binds $mod + [shift +] {1..0} to move to workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
        10)
      );
    };
  };

  # Bar: waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        start_hidden = true;
        # mode = "overlay"; # Temporary workaround for waybar bug
        margin-bottom = 5;
        position = "bottom";
        layer = "top";
        height = 35;
        spacing = 4;
        modules-left = [
          "hyprland/workspaces"
          # "custom/media"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "idle_inhibitor"
          # "keyboard-state"
          "network"
          "pulseaudio"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          # "backlight"
          # "battery"
          # "battery#bat2"
          "clock"
          "tray"
        ];

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
              locked = "";
              unlocked = "";
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "{:%H:%M %d-%m-%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons =  ["" "" ""];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        battery = {
          states = {
            # good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-icons = ["" "" "" "" ""];
        };

        "battery#bat2" = {
          bat = "BAT2";
        };

        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        network = {
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
            # "scroll-step": 1, # %, can be a float
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
        };

        "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
                default = "🎜";
            };
            escape = true;
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
            # exec = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null"; # Filter player based on name
        };

      };
    };
    style = ''
      @import "${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.css";

      * {
        color: @text;
      }

      window#waybar {
        background-color: shade(@base, 0.9);
        border: 2px solid alpha(@crust, 0.3);
      }

      label.module {
        padding: 0px 10px;
        border: 1px solid @${lib.toLower colorSchemeAccent};
      }

      box.module {
        padding: 0px 10px;
        border: 1px solid @overlay0;
      }
    '';
  };

  # Application launcher: rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    cycle = true;
    theme = "${lib.toLower colorSchemeString}";
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Papirus-${colorSchemeMode}";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };
    pass = {
      package = pkgs.rofi-pass-wayland;
    };
  };

  # Notification daemon: dunst
  services.dunst = {
    enable = true;
    configFile = "$HOME/.config/dunst/dunstrc_themed"; # May have to disable this and re-enable to get the desired effect. Due ordering issues.
    waylandDisplay = "wayland-1";
  };

  # Clipboard history: copyq
  services.copyq.enable = true;
  services.cliphist.enable = true;

  # Audio effects: easyeffects
  services.easyeffects = {
    enable = true;
  };

  # Multi-device integration: kdeconnect
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # CLI cheatsheet: tldr (with auto-update)
  services.tldr-update = {
    enable = true;
    package = pkgs.tldr;
  };
  

  # Screen drawing: gromit-mpx
  services.gromit-mpx = {
    enable = false; # true; # As this sucks
    tools = [
      {
        color = "red";
        device = "default";
        size = 5;
        type = "pen";
      }
      {
        color = "blue";
        device = "default";
        modifiers = [
          "SHIFT"
        ];
        size = 5;
        type = "pen";
      }
      {
        color = "yellow";
        device = "default";
        modifiers = [
          "CONTROL"
        ];
        size = 5;
        type = "pen";
      }
      {
        arrowSize = 1;
        color = "green";
        device = "default";
        modifiers = [
          "2"
        ];
        size = 6;
        type = "pen";
      }
      {
        device = "default";
        modifiers = [
          "3"
        ];
        size = 75;
        type = "eraser";
      }
    ];
  };

  # dconf for dark theme and other stuff
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # Shell and shell utilities

  ## Default shell: zsh
  programs.zsh = {
    enable = true;
    zprof.enable = false; # Profiling zsh
    # defaultKeymap = "viins";
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [
      "main"
      "brackets"
      "cursor"
      "root"
      "line"
    ];
    # History
    history = {
      ignoreSpace = true;
    };
    # Source session variables
    initContent = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      function zvm_after_init() {
        emulate -LR zsh
        # spacebar expands abbreviations
        bindkey " " abbr-expand-and-insert
        # control-spacebar is a normal space
        bindkey "^ " magic-space
        # when running an incremental search,
        # spacebar behaves normally and control-space expands abbreviations
        bindkey -M isearch "^ " abbr-expand-and-insert
        bindkey -M isearch " " magic-space
        # enter key expands and accepts abbreviations
        # bindkey "^M" abbr-expand-and-accept
      }
    '';

    # Aliases
    shellAliases = {
      cd = "z";
    };

    ## zsh framework: none # prezto (disabled)
    /*prezto = {
      enable = true;
      editor.keymap = "vi";
    };*/

    ## Plugins
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    ## Abbreviations: zsh-abbr
    zsh-abbr.enable = true;
    zsh-abbr.abbreviations = {
      cupd = "rm ~/.mozilla/firefox/default/containers.json ~/.gtkrc-2.0";
      nswt = "sudo nixos-rebuild switch --flake '/home/arun/arun-nix-config/#arun_nixos_default'";
      hswt = "sudo -i nix-channel --update && home-manager switch --flake '/home/arun/arun-nix-config/#arun_home_default'";
      hupd = "home-manager switch --flake '/home/arun/arun-nix-config/#arun_home_default'";
      upd = "sudo nixos-rebuild switch --flake '/home/arun/arun-nix-config/#arun_nixos_default' && sudo -i nix-channel --update && home-manager switch --flake '/home/arun/arun-nix-config/#arun_home_default'";
      fupd = "nix flake update";
      uchan  = "nix-channel --update";
      niupd = "nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'";
      ngc = "nix-collect-garbage --delete-older-than 15d";
      sui = "sudo -i ";
      cht = "curl https://cht.sh/";
      ginit = "git init";
      gadd = "git add -A";
      gcom = "git commit -m \"";
      game = "git commit --amend -m \"";
      gamne = "git commit --amend --no-edit";
      gpush = "git push";
      gpull = "git pull";
      gco = "git checkout";
      gbc = "git checkout -b";
      grst = "git reset --hard";
      gstat = "git status";
      gdiff = "git diff HEAD";
      glog = "git log";
      tree = "ls --tree";
      perr = "2>&1 >/dev/null |";
      wclip = "| wl-copy";
    };
  };

  ## Shell theme: starship
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$all";
      palette = lib.toLower (builtins.replaceStrings [ "-" ] [ "_" ] colorSchemeString);
    } // builtins.fromTOML (builtins.readFile
      (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "starship";
          rev = "5629d23";
          sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
        } + /palettes/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.toml));
  };

  ## Shell environment management: direnv
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  ## Terminal multiplexer: tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
  };

  ## Search utility: ripgrep
  programs.ripgrep = {
    enable = true;
  };

  ## Text editor: helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        # mouse = false;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        soft-wrap = {
          enable = true;
        };
      };
    };
  };

  # Shell Utilities

  ## Pager: bat
  programs.bat = {
    enable = true;
    config = {
      theme = colorSchemeString;
    };
    themes = {
      Catppuccin-Mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "a875b71";
          sha256 = "PWX8LR3xTgNBUpk+xBIGpEBQCNJHre8cRX4OTSWkZvs=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
      Catppuccin-Latte = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "a875b71";
          sha256 = "PWX8LR3xTgNBUpk+xBIGpEBQCNJHre8cRX4OTSWkZvs=";
        };
        file = "themes/Catppuccin Latte.tmTheme";
      };
      Catppuccin-Macchiato = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "a875b71";
          sha256 = "PWX8LR3xTgNBUpk+xBIGpEBQCNJHre8cRX4OTSWkZvs=";
        };
        file = "themes/Catppuccin Macchiato.tmTheme";
      };
      Catppuccin-Frappe = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "a875b71";
          sha256 = "PWX8LR3xTgNBUpk+xBIGpEBQCNJHre8cRX4OTSWkZvs=";
        };
        file = "themes/Catppuccin Frappe.tmTheme";
      };
    };
  };

  ## Process viewer/manager: btop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = lib.toLower (builtins.replaceStrings [ "-" ] [ "_" ] colorSchemeString);
    };
  };

  ## Downloader: aria2
  programs.aria2 = {
    enable = true;
  };

  ## Fuzzy finder: fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
    colors = fzf_color_scheme.${colorSchemeString};
  };

  ## Improved cd: zoxide
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  ## Improved ls: eza
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  ## JSON processor: jq
  programs.jq = {
    enable = true;
  };

  ## Terminal file manager: lf
  programs.lf = {
    enable = true;
    settings = {
      shell = "zsh";
      hidden = true;
      icons = true;
      mouse = true;
      relativenumber = true;
    };
    previewer = {
      source = "${pkgs.ctpv}/bin/ctpv";
      keybinding = "i";
    };
    extraConfig = ''
      &${pkgs.ctpv}/bin/ctpv -s $id
      cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
      set cleaner ${pkgs.ctpv}/bin/ctpvclear
    '';
  };

  ## VCS: git
  programs.git = {
    enable = true;
    userName = "arun5309";
    userEmail = "arun5309@gmail.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  ## Terminal helper for git: lazygit
  programs.lazygit = {
    enable = true;
  };

  # Graphical applications

  ## Terminal emulator:
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    themeFile = colorSchemeString;
  };

  ## Video player (minimalistic): mpv
  programs.mpv = {
    enable = true;
  };

  ## Image viewer (minimalistic): imv
  programs.imv = {
    enable = true;
  };

  ## Screen recording (also broadcasting, etc.): OBS Studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      # obs-multi-rtmp
      obs-gstreamer
      obs-vaapi
      waveform
      input-overlay
      # obs-replay-source
      obs-pipewire-audio-capture
      # advanced-scene-switcher
      obs-livesplit-one
      obs-command-source
      obs-backgroundremoval
      obs-3d-effect
      obs-mute-filter
      obs-text-pthread
      obs-shaderfilter
      obs-freeze-filter
      # looking-glass-obs
      obs-vintage-filter
      obs-scale-to-sound
      obs-composite-blur
      # obs-vertical-canvas
      obs-source-switcher
      obs-move-transition
      obs-gradient-source
      # obs-transition-table
      # obs-rgb-levels-filter
      # obs-ndi
      # obs-tuna
      # obs-nvfbc
      obs-teleport
      # obs-hyperion
      # droidcam-obs
      obs-websocket
      obs-webkitgtk
    ];
  };

  ## Browser: firefox
  programs.firefox = {
    enable = true;

    policies = {
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      FirefoxSuggest = {
        SponsoredSuggestions = false;
      };
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      StartDownloadsInTempDirectory = true;
    };

    profiles.default = {

    settings = {
      # Hardening based on: https://brainfucksec.github.io/firefox-hardening-guide

      # Startup settings
      "browser.aboutConfig.showWarning" = false;
      "browser.startup.page" = 1;
      "browser.startup.homepage" = "about:home";
      "browser.newtabpage.enabled" = false;
      "browser.newtab.preload" = true; # Overrided
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.default.sites" = "";

      # Geolocation
      "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
      "geo.provider.use_gpsd" = false;
      "geo.provider.use_geoclue" = false;
      "browser.region.network.url" = "";
      "browser.region.update.enabled" = false;

      # Language/Locale
      "intl.accept_languages" = "en-US, en";
      "javascript.use_us_english_locale" = true;

      # Auto-update/Recommendations
      "app.update.auto" = false;
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.discovery.enabled" = false;

      # Telemetry
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.coverage.opt-out" = true;
      "toolkit.coverage.endpoint.base" = "";
      "browser.ping-centre.telemetry" = false;
      "beacon.enabled" = false;

      # Studies
      "app.shield.optoutstudies.enabled" = false;
      "app.normandy.enabled" = false;
      "app.normandy.api_url" = "";

      # Crash Reports
      "breakpad.reportURL" = "";
      "browser.tabs.crashReporting.sendReport" = false;

      # Captive portal detection / Network Checks
      "captivedetect.canonicalURL" = "";
      "network.captive-portal-service.enabled" = false;
      "network.connectivity-service.enabled" = false;

      # Safe browsing
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      "browser.safebrowsing.blockedURIs.enabled" = false;
      "browser.safebrowsing.provider.google4.gethashURL" = "";
      "browser.safebrowsing.provider.google4.updateURL" = "";
      "browser.safebrowsing.provider.google.gethashURL" = "";
      "browser.safebrowsing.provider.google.updateURL" = "";
      "browser.safebrowsing.provider.google4.dataSharingURL" = "";
      "browser.safebrowsing.downloads.enabled" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
      "browser.safebrowsing.allowOverride" = false;

      # Network: DNS, Proxy, IPv6
      "network.prefetch-next" = true;  # Overrided
      "network.dns.disablePrefetch" = false;  # Overrided
      "network.predictor.enabled" = true;  # Overrided
      # "network.http.speculative-parallel-limit" = 0;  # Overrided
      "browser.places.speculativeConnect.enabled" = true;  # Overrided
      "network.dns.disableIPv6" = false;  # Overrided
      "network.gio.supported-protocols" = "";
      "network.file.disable_unc_paths" = true;
      "permissions.manager.defaultsUrl" = "";
      "network.IDN_show_punycode" = true;

      # Search bar: Suggestions, Autofill
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.fixup.alternate.enabled" = false;
      "browser.urlbar.trimURLs" = false;
      "browser.urlbar.speculativeConnect.enabled" = false;
      "browser.formfill.enable" = false;
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.available" = "off";
      "extensions.formautofill.creditCards.available" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "extensions.formautofill.heuristics.enabled" = false;
      "browser.urlbar.quicksuggest.scenario" = "history";
      "browser.urlbar.quicksuggest.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;

      # Passwords
      "signon.rememberSignons" = false;
      "signon.autofillForms" = false;
      "signon.formlessCapture.enabled" = false;
      "network.auth.subresource-http-auth-allow" = 1;

      # Disk Cache/Memory
      "browser.cache.disk.enable" = true;  # Overrided
      "browser.sessionstore.privacy_level" = 2;
      "browser.sessionstore.resume_from_crash" = true; # Overrided
      "browser.pagethumbnails.capturing_disabled" = true;
      "browser.shell.shortcutFavicons" = false;
      "browser.helperApps.deleteTempFileOnExit" = true;

      # HTTPS / SSL/TLS / OSCP / CERTS
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_send_http_background_request" = false;
      "browser.xul.error_pages.expert_bad_cert" = true;
      "security.tls.enable_0rtt_data" = false;
      "security.OCSP.require" = true;
      "security.pki.sha1_enforcement_level" = 1;
      "security.cert_pinning.enforcement_level" = 2;
      "security.remote_settings.crlite_filters.enabled" = true;
      "security.pki.crlite_mode" = 2;

      # Headers/Referers
      "network.http.referer.XOriginPolicy" = 2;
      "network.http.referer.XOriginTrimmingPolicy" = 2;

      # Audio/Video: WebRTC, WebGL, DRM
      "media.peerconnection.enabled" = true; # Overrided
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      "media.peerconnection.ice.default_address_only" = true;
      "media.peerconnection.ice.no_host" = true;
      "webgl.disabled" = false; # Overrided
      "media.autoplay.default" = 5;
      "media.eme.enabled" = false; # Override?

      # Downloads
      "browser.download.useDownloadDir" = false;
      "browser.download.manager.addToRecentDocs" = false;

      # Cookies
      "browser.contentblocking.category" = "strict";
      "privacy.partition.serviceWorkers" = true;
      "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
      "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = true;

      # UI Features
      "dom.disable_open_during_load" = true;
      "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
      "extensions.pocket.enabled" = false;
      "extensions.Screenshots.disabled" = true;
      "pdfjs.enableScripting" = false;
      "privacy.userContext.enabled" = true;

      # Extensions
      "extensions.enabledScopes" = 5;
      "extensions.webextensions.restrictedDomains" = "";
      "extensions.postDownloadThirdPartyPrompt" = false;

      # Shutdown Settings
      "network.cookie.lifetimePolicy" = 2;
      "privacy.sanitize.sanitizeOnShutdown" = true;
      "privacy.clearOnShutdown.cache" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.formdata" = true;
      "privacy.clearOnShutdown.history" = false; # Overrided
      "privacy.clearOnShutdown.offlineApps" = true;
      "privacy.clearOnShutdown.sessions" = true;
      "privacy.clearOnShutdown.sitesettings" = false;
      "privacy.sanitize.timeSpan" = 0;

      # Fingerprinting
      "privacy.resistFingerprinting" = false; # Overrided
      "privacy.window.maxInnerWidth" = 1600;
      "privacy.window.maxInnerHeight" = 900;
      "privacy.resistFingerprinting.block_mozAddonManager" = true;
      "browser.display.use_system_colors" = false;
      "browser.startup.blankWindow" = false;

      # Non-hardening

      # Use system dark mode (for prefers color scheme)
      "ui.systemUsesDarkTheme" = if colorSchemeMode == "Dark" then 1 else (if colorSchemeMode == "Light" then 0 else 2);
      "browser.in-content.dark-mode" = colorSchemeMode == "Dark";
      # TODO: as both methods above don't work without disabling resistFingerprinting
    };

    containers= {
      fun = {
        id = 1;
        icon = "circle";
        color = "blue";
      };

      iisc = {
        id = 2;
        icon = "briefcase";
        color = "green";
      };

      throwaway = {
        id = 3;
        icon = "fence";
        color = "red";
      };
    };

    search.engines = {
      "Nix wiki" = {
        urls = [{
          template = "https://nixos.wiki/index.php";
          params = [
            { name = "search"; value = "{searchTerms}"; }
            { name = "go"; value = "Go"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@nw" ];
      };

      "Nix packages" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "channel"; value = "unstable"; }
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "Nix options" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "channel"; value = "unstable"; }
            { name = "type"; value = "options"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
      };

      "Nix flakes" = {
        urls = [{
          template = "https://search.nixos.org/flakes";
          params = [
            { name = "type"; value = "flakes"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@nf" ];
      };

      "Home manager options" = {
        urls = [{
          template = "https://home-manager-options.extranix.com";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "https://home-manager-options.extranix.com/images/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = [ "@ho" ];
      };

      "Brave search" = {
        urls = [{
          template = "https://search.brave.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
            { name = "source"; value = "web"; }
          ];
        }];

        icon = "https://brave.com/favicon.ico";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = [ "@bs" ];
      };
    };
    search.force = true;
    search.default = "Brave search";
    search.privateDefault = "Brave search";

    extensions.packages = with inputs.firefox-addons.packages.${system}; [
      ublock-origin
      sponsorblock
      tridactyl
      darkreader
      firefox-color
    ];
    };
  };

  programs.pandoc = {
    enable = true;
  };
}
