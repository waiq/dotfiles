# Home Manager (flake)

This folder contains a Home Manager configuration defined by `flake.nix` and `home.nix`.

## Prereqs

- Nix installed
- Home Manager available (either installed or run via `nix`)

## Apply changes

From this folder:

```bash
home-manager switch --flake .#waiq
```

If you prefer not to install Home Manager globally, you can run it via `nix`:

```bash
nix run github:nix-community/home-manager -- switch --flake .#waiq
```

## Update inputs

To update `flake.lock` to the latest inputs:

```bash
nix flake update
```

## Files

- `flake.nix`: flake entrypoint and Home Manager configuration
- `home.nix`: your Home Manager module
- `flake.lock`: pinned input versions
