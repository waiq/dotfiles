
{ config, pkgs, ... }:

{
  home.username = "waiq";
  home.homeDirectory = "/home/waiq";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    stow
    dbeaver-bin
    go-mockery
    gotestsum
    duckdb
    grpcurl
    curl
    git
    lazygit
    terraform-local
    neovim
    lua51Packages.luarocks
    tmux
    htop
    jq
    ripgrep
    fzf
  ];
  programs.home-manager.enable = true;
}
