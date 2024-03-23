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
    nerdfonts
    file
    silver-searcher
    buku
    fastfetch
    unixtools.xxd
    ffmpeg-full
    imagemagick
    w3m
    sloccount
    rlwrap
    pdftk
    pdfsandwich
    espeak
    graphviz
    ctpv
    wlogout
    hyprlock
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
    # EDITOR = "emacs";
    PAGER = "bat";
    VISUAL = "bat";
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
      name = "adw-gtk3-dark"; # "${colorSchemeString}-Compact-${colorSchemeAccent}-${colorSchemeMode}";
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

  qt = {
    enable = true;
    #platformTheme = "kde";
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
    settings = {
      source = [ "~/.config/hypr/${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}.conf" ];
      "$mod" = "SUPER";
      env = [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];
      exec-once = [
        # "hyprlock"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      bind = let monocle = "dwindle:no_gaps_when_only"; in [
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, G, togglegroup"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit"
        "$mod, T, togglefloating"
        "$mod, P, pseudo"
        "$mod ALT, ,resizeactive,"

        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | ${pkgs.json2tsv}/bin/jaq -r '.int') ^ 1))"

        "$mod, Escape, exec, wlogout -p layer-shell"
        "$mod SHIFT, L, exec, loginctl lock-session"
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

        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, VGA-1"

        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        "$mod SHIFT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod SHIFT, bracketright, movecurrentworkspacetomonitor, r"

        "$mod, D, exec, rofi -show run"
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

  # Application launcher
  programs.rofi = {
    enable = true;
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

    # Source session variables
    initExtra = ''
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
        bindkey "^M" abbr-expand-and-accept
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
    icons = true;
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
    theme = colorSchemeString;
  };

  ## Video player (minimalistic): mpv
  programs.mpv = {
    enable = true;
  };

  ## Image viewer (minimalistic): imv
  programs.imv = {
    enable = true;
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
      "browser.newtab.preload" = false;
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
      "network.prefetch-next" = false;
      "network.dns.disablePrefetch" = true;
      "network.predictor.enabled" = false;
      "network.http.speculative-parallel-limit" = 0;
      "browser.places.speculativeConnect.enabled" = false;
      "network.dns.disableIPv6" = true;
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
      "browser.cache.disk.enable" = false;
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

        iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
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

        iconUpdateURL = "https://brave.com/favicon.ico";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = [ "@bs" ];
      };
    };
    search.force = true;
    search.default = "Brave search";
    search.privateDefault = "Brave search";

    extensions = with inputs.firefox-addons.packages.${system}; [
      ublock-origin
      sponsorblock
      tridactyl
      darkreader
      firefox-color
    ];
    };
  };
}
