{
  description = "Arun NixOS and nix home configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Xremap flake
    xremap-flake.url = "github:xremap/nix-flake";

    # Hyprland flake (makes installation of plugins more convenient)
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      # inputs.hyprland.follows = "hyprland";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      # inputs.hyprland.follows = "hyprland";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      # inputs.hyprland.follows = "hyprland";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      # inputs.hyprland.follows = "hyprland";
    };
    xdg-desktop-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      # inputs.hyprland.follows = "hyprland";
    };

    # Nix pre-built index
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Firefox addons NUR package
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      allowed-unfree-packages = [
        "zsh-abbr"
      ];

      colorSchemeMode = "Dark"; # Light
      colorSchemeString = "Catppuccin-Mocha"; # Preferred dark theme
      # colorSchemeString = "Catppuccin-Latte"; # Light theme
      # colorSchemeString = "Catppuccin-Macchiato";
      # colorSchemeString = "Catppuccin-Frappe";

      colorSchemeAccent = "Mauve";

      fzf_color_scheme = {
        "Catppuccin-Mocha" = {
          "bg+" = "#313244";
          "bg" = "#1e1e2e";
          "spinner" = "#f5e0dc";
          "hl" = "#f38ba8";
          "fg" = "#cdd6f4";
          "header" = "#f38ba8";
          "info" = "#cba6f7";
          "pointer" = "#f5e0dc";
          "marker" = "#f5e0dc";
          "fg+" = "#cdd6f4";
          "prompt" = "#cba6f7";
          "hl+" = "#f38ba8";
        };
        "Catppuccin-Latte" = {
          "bg+" = "#ccd0da";
          "bg" = "#eff1f5";
          "spinner" = "#dc8a78";
          "hl" = "#d20f39";
          "fg" = "#4c4f69";
          "header" = "#d20f39";
          "info" = "#8839ef";
          "pointer" = "#dc8a78";
          "marker" = "#dc8a78";
          "fg+" = "#4c4f69";
          "prompt" = "#8839ef";
          "hl+" = "#d20f39";
        };
        "Catppuccin-Macchiato" = {
          "bg+" = "#363a4f";
          "bg" = "#24273a";
          "spinner" = "#f4dbd6";
          "hl" = "#ed8796";
          "fg" = "#cad3f5";
          "header" = "#ed8796";
          "info" = "#c6a0f6";
          "pointer" = "#f4dbd6";
          "marker" = "#f4dbd6";
          "fg+" = "#cad3f5";
          "prompt" = "#c6a0f6";
          "hl+" = "#ed8796";
        };
        "Catppuccin-Frappe" = {
          "bg+" = "#414559";
          "bg" = "#303446";
          "spinner" = "#f2d5cf";
          "hl" = "#e78284";
          "fg" = "#c6d0f5";
          "header" = "#e78284";
          "info" = "#ca9ee6";
          "pointer" = "#f2d5cf";
          "marker" = "#f2d5cf";
          "fg+" = "#c6d0f5";
          "prompt" = "#ca9ee6";
          "hl+" = "#e78284";
        };
      };

    in
    {
      nixosConfigurations = {
        arun_nixos_default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system inputs; };

          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

#       home-manager.users.arun = {
#         dconf = {
#           enable = true;
#           settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
#         };
#       };

      homeConfigurations = {
        arun_home_default = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit system allowed-unfree-packages colorSchemeMode colorSchemeString colorSchemeAccent fzf_color_scheme inputs; };

          pkgs = nixpkgs.legacyPackages.${system};

          modules = [
            nix-index-database.hmModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            ./home-manager/home.nix
            #./home-manager/dummy_home.nix
          ];
        };
      };
    };
}
