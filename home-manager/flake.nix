{
  description = "Home Manager configuration of waiq";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = modules: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = modules;
      };
    in
    {
      # Legacy/default target kept stable during migration.
      homeConfigurations."waiq" = mkHome [ ./home.nix ];

      # Migration targets by concern.
      homeConfigurations."waiq-nix" = mkHome [
        ./modules/base.nix
      ];

      homeConfigurations."waiq-config" = mkHome [
        ./modules/base.nix
      ];

      # Profile overlays (scaffold).
      homeConfigurations."waiq-work" = mkHome [
        ./modules/base.nix
        ./profiles/work.nix
      ];

      homeConfigurations."waiq-home" = mkHome [
        ./modules/base.nix
        ./profiles/home.nix
      ];
    };
}
