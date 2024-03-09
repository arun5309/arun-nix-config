{ config, pkgs, lib, inputs, allowed-unfree-packages, ... }:

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
  home.packages = [
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

  # My custom programs

  # Default shell: zsh
  programs.zsh = {
    enable = true;
    zprof.enable = false; # Profiling zsh
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

    # zsh framework
    prezto = {
      enable = true;
      editor.keymap = "vi";
    };

    ## Abbreviations
    zsh-abbr.enable = true;
    zsh-abbr.abbreviations = {
      nswt = "sudo nixos-rebuild switch --flake /home/arun/arun-nix-config/ 'arun_nixos_default'";
      hswt = "sudo -i nix-channel --update && home-manager switch --flake /home/arun/arun-nix-config/ 'arun_home_default'";
      upd = "nswt && hswt";
    };
  };

  ## shell theme
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "arun5309";
    userEmail = "arun5309@gmail.com";
  };

  # Firefox
  programs.firefox = {
    enable = true;
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

    extensions = [
      inputs.firefox-addons.packages."x86_64-linux".ublock-origin
      inputs.firefox-addons.packages."x86_64-linux".sponsorblock
      inputs.firefox-addons.packages."x86_64-linux".tridactyl
      inputs.firefox-addons.packages."x86_64-linux".darkreader
    ];
    };
  };
}
