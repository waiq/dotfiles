# Compatibility exports/aliases ported from legacy roles.
export DROPBOX_PATH="${DROPBOX_PATH:-$HOME/Dropbox}"

if command -v flatpak >/dev/null 2>&1; then
  alias discord='flatpak run com.discordapp.Discord'
fi
