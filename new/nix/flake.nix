{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # jira-cli v3
    nixpkgs-jira.url = "github:NixOS/nixpkgs/7d0ed7f2e5aea07ab22ccb338d27fbe347ed2f11";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixpkgs-jira,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    homeConfigurations = {
      waiq = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}

