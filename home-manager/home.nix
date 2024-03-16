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
    "x-scheme-handler/hanually source 'hm-session-vars.sh' located atttps" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
  };

  # Theming and colors

  # TODO: SDDM, gtk, qt theming

  # GTK theming

  gtk = {
    enable = true;
    theme = {
      name = "${colorSchemeString}-Compact-${colorSchemeAccent}-${colorSchemeMode}";
      package = pkgs.catppuccin-gtk.override {
        accents = [ (lib.toLower colorSchemeAccent) ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2);
      };
    };
    cursorTheme = {
      name = "${lib.toLower (builtins.elemAt (builtins.split "-" colorSchemeString) 2)}${colorSchemeAccent}";
      package = pkgs.catppuccin-cursors;
    };
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
    platformTheme = "kde";
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

  # Shell and shell utilities

  ## Default shell: zsh
  programs.zsh = {
    enable = true;
    zprof.enable = false; # Profiling zsh
    defaultKeymap = "viins";
    enableAutosuggestions = true;
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

    ## Abbreviations: zsh-abbr
    zsh-abbr.enable = true;
    zsh-abbr.abbreviations = {
      nswt = "sudo nixos-rebuild switch --flake '/home/arun/arun-nix-config/#arun_nixos_default'";
      hswt = "sudo -i nix-channel --update && home-manager switch --flake '/home/arun/arun-nix-config/#arun_home_default'";
      hupd = "home-manager switch --flake '/home/arun/arun-nix-config/#arun_home_default'";
      upd = "sudo nixos-rebuild switch --flake '/home/arun/arun-nix-config/#arun_nixos_default' && sudo -i nix-channel --update && home-manager switch --flake '/home/arun/arun-nix-config/#arun_home_default'";
      cht = "curl https://cht.sh/";
      ginit = "git init";
      gadd = "git add -A";
      gcom = "git commit -m '";
      game = "git commit --amend";
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
    enableAliases = true;
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
    shellIntegration.enableZshIntegration = true;
    theme = colorSchemeString;
  };

  ## Video player (minimalistic): mpv
  programs.mpv = {
    enable = true;
  };

  ## Image viewer (minimalistic): feh
  programs.feh = {
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
          template = "https://mipmip.github.io/home-manager-option-search";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        iconUpdateURL = "https://mipmip.github.io/home-manager-option-search/images/favicon.png";
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
