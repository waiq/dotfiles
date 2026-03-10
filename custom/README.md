# custom (Deprecated Reference)

`custom/` contains legacy Ansible role source material kept for migration reference.

## Authority

- Do not treat files in `custom/` as source of truth.
- Authoritative package/runtime/service config lives in `home-manager/`.
- Authoritative dotfile/shell config lives in `stow/`.

## Editing Rule

- Do not introduce new behavior in `custom/`.
- When updating user-facing config, edit `stow/` (and `home-manager/` for package/service ownership).
