{ pkgs, ... }:

{
  home.username = "waiq";
  home.homeDirectory = "/home/waiq";

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
    cargo
    rustfmt
    cargo-watch
    jira-cli-go
    whisper-cpp
    ffmpeg
    espeak-ng
    sox
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
