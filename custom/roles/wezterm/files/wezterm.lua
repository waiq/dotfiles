-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Setup color_scheme:
config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = false

config.audible_bell = "Disabled"

config.font = wezterm.font("JetBrainsMono Nerd Font")

return config
