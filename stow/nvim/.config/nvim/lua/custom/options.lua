local opt = vim.opt
local g = vim.g

-- If the tmux window is zoomed, keep it zoomed when moving from Vim to another pane
g.tmux_navigator_preserve_zoom = 1

-- tmux navigation
g.tmux_navigator_no_mappings = 1

-- put all temp files in /tmp
opt.dir = "/tmp"

-- Indenting
opt.expandtab = false
opt.smartindent = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 4
opt.softtabstop = 4


-- 80 char or die!
opt.colorcolumn = "80"
