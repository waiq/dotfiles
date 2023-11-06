local M = {}
M.disabled = {
	n = {
		-- disable the default open terminal
		["<A-h>"] = "",
		-- disable tab as FRICKING JUMPER!!!!!
		["<tab>"] = "",
		-- enable C-I as jump forward
		["<C-I>"] = "<C-I>",
	},
}

local orgpath = os.getenv("ORGPATH") or "~/.my-orgs/"
M.general = {
	n = {
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

		["<A-k>"] = { ":resize +1<CR>", "resize up" },
		["<A-j>"] = { ":resize -1<CR>", "resize down" },
		["<A-l>"] = { ":vertical resize +1<CR>", "resize right" },
		["<A-h>"] = { ":vertical resize -1<CR>", "resize left" },

		["<C-b>"] = { "^", "Beginning of line" },
		["<C-e>"] = { "<End>", "End of line" },

		-- ["<C-y>"] = { "<cmd>lua require('custom.resize').get_tmux_pane<cr>", "test" },

		-- org mode my notes
		["<leader>not"] = { ":cd" .. orgpath .. "<CR>", "jump to org folder" },
	},
}

M.harpoon = {
	n = {
		["<leader>aa"] = {
			function()
				require("harpoon.mark").add_file()
			end,
			"harpoon add file",
		},
		["<leader>al"] = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			"harpoon add file",
		},
	},
}

M.dap = {
	n = {
		["<leader>dc"] = {
			function()
				require("dap").continue()
			end,
			"Dap continue",
		},

		["<leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"toggle break point",
		},

		["<leader>dn"] = {
			function()
				require("dap").step_over()
			end,
			"Dap step over",
		},

		["<leader>di"] = {
			function()
				require("dap").step_info()
			end,
			"Dap step into",
		},

		["<leader>do"] = {
			function()
				require("dap").step_out()
			end,
			"Dap step out",
		},

		["<leader>dr"] = {
			function()
				require("dap").repl.open()
			end,
			"Dap repl open",
		},

		["<leader>dl"] = {
			function()
				require("dap").run_last()
			end,
			"Dap last run",
		},
		["<leader>dtt"] = {
			function()
				require("dap").terminate()
			end,
			"Dap last run",
		},
		["<leader>dh"] = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"Dap hover",
		},

		["<leader>dp"] = {
			function()
				require("dap.ui.widgets").preview()
			end,
			"Dap preview",
		},

		["<leader>df"] = {
			function()
				require("dap.ui.widgets").frame()
			end,
			"Dap frame",
		},

		["<leader>ds"] = {
			function()
				require("dap.ui.widgets").scopes()
			end,
			"Dap scopes",
		},
		["<leader>dw"] = {
			function()
				require("dapui").toggle()
			end,
		},
	},
}

M.nvimtree = {
	n = {
		["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
	},
}

M.tabufline = {
	n = {
		-- cycle through buffers
		["<S-l>"] = {
			function()
				require("nvchad.tabufline").tabuflineNext()
			end,
			"Goto next buffer",
		},

		["<S-h>"] = {
			function()
				require("nvchad.tabufline").tabuflinePrev()
			end,
			"Goto prev buffer",
		},

		-- close buffer + hide terminal buffer
		["<S-q>"] = {
			function()
				require("nvchad.tabufline").close_buffer()
			end,
			"Close buffer",
		},
	},
}

return M
