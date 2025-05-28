
{ config, pkgs, ... }:

{
  home.username = "waiq";
  home.homeDirectory = "/home/waiq";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    neofetch
  ];
  programs.home-manager.enable = true;
}
