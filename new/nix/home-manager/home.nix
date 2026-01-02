{ config, pkgs, ... }:

{
  home.username = "waiq";
  home.homeDirectory = "/home/waiq";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    stow
    dbeaver-bin
    go
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
    mitmproxy
    zoxide
    protoc-gen-go
    protobuf
    golangci-lint
    rust-analyzer
    rustc
  ];

  programs.home-manager.enable = true;
}
