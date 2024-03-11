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

    # Firefox addons NUR package
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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

      colorSchemeString = "Catppuccin-Mocha"; # Preferred dark theme
      # colorSchemeString = "Catppuccin-Latte"; # Light theme
      # colorSchemeString = "Catppuccin-Macchiato";
      # colorSchemeString = "Catppuccin-Frappe";

    in
    {
      nixosConfigurations = {
        arun_nixos_default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system; };

          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        arun_home_default = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit system allowed-unfree-packages colorSchemeString inputs; };

          pkgs = nixpkgs.legacyPackages.${system};

          modules = [
            ./home-manager/home.nix
          ];
        };
      };
    };
}
