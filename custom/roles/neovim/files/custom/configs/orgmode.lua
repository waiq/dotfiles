-- Load custom treesitter grammar for org filetype
require("orgmode").setup_ts_grammar()

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
	-- If TS highlights are not enabled at all, or disabled via `disable` prop,
	-- highlighting will fallback to default Vim syntax highlighting
	highlight = {
		enable = true,
		-- Required for spellcheck, some LaTex highlights and
		-- code block highlights that do not have ts grammar
		additional_vim_regex_highlighting = { "org" },
	},
	ensure_installed = { "org" }, -- Or run :TSUpdate org
})

local orgpath = os.getenv("ORGPATH") or "~/.my-orgs/"
if not vim.fn.isdirectory(orgpath) then
	vim.notify(orgpath .. "dont exists")
	return
end

local agendapath = orgpath .. "/agenda"
local notepath = orgpath .. "/notes"

require("orgmode").setup({
	org_agenda_files = { agendapath .. "/**/*" },
	org_default_notes_file = notepath .. "/notes.org",
	org_todo_keywords = { "TODO", "WAITING", "INPROGRESS", "|", "CANCELED", "DONE", "DELEGATED" },
	org_todo_keyword_faces = {
		WAITING = ":foreground #F9E2AF :weight bold",
		INPROGRESS = ":foreground #89B4FA :weight bold",
		DELEGATED = ":foreground #94E2D5 :background #1E1E2E :slant italic :underline on",
		DONE = ":foreground #94E2D5 :weight bold",
		TODO = ":background #1E1E2E :foreground #F38BA8", -- overrides builtin color for `TODO` keyword
	},
})

require("org-bullets").setup({
	concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
	symbols = {
		-- list symbol
		list = "•",
		-- headlines can be a list
		headlines = { "◉", "○", "✸", "✿" },
		-- or a function that receives the defaults and returns a list
		-- headlines = function(default_list)
		-- 	table.insert(default_list, "♥")
		-- 	return default_list
		-- end,
		checkboxes = {
			half = { "", "OrgTSCheckboxHalfChecked" },
			done = { "✓", "OrgDone" },
			todo = { "˟", "OrgTODO" },
		},
	},
})
