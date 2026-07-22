{ pkgs, lib, ... }:


{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "mongodb-compass"
      "obsidian"
      "dropbox"
      "firefox-bin"
      "firefox-bin-unwrapped"
      "slack"
      "spotify"
      "zoom"
      "zoom-us"
      "discord"
    ];

  home.username = "waiq";
  home.homeDirectory = "/home/waiq";

  home.sessionPath = [
    "$HOME/.local/npm-global/bin"
  ];

  home.packages = with pkgs; [
    oh-my-posh
    stow
    awscli2
    dbeaver-bin
    go
    go-mockery
    gotestsum
    duckdb
    dropbox
    grpcurl
    curl
    git
    lazygit
    difftastic
    terraform-local
    neovim
    neovim-remote
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
    clippy
    lldb
    cargo-watch
    jira-cli-go
    whisper-cpp
    ffmpeg
    espeak-ng
    sox
    flatpak
    nerd-fonts.jetbrains-mono
    obsidian
    mongodb-compass
    slack
    discord
    spotify
    wezterm
    zoom-us
    nodejs
    yazi
    pv
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
