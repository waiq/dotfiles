-- My plugins

local plugins = {
	{
		"ThePrimeagen/harpoon",
		lazy = false,
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
	},
	{
		"nvim-orgmode/orgmode",
		dependencies = { "akinsho/org-bullets.nvim" },
		lazy = false,
		config = function()
			require("custom.configs.orgmode")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("custom.configs.dap-ui")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("custom.configs.oil")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("custom.configs.dap")
		end,
	},

	{
		-- dont use the dap or lspconfig,
		-- use the jdtls own setup
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap", "neovim/nvim-lspconfig" },
		event = "VeryLazy",
		config = function()
			require("custom.configs.java")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("custom.configs.null-ls")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = function()
			return require("custom.configs.mason")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = function()
			return require("custom.configs.treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		opts = function()
			return require("custom.configs.todo_comments")
		end,
	},
	{
		"folke/which-key.nvim",
		opts = {
			triggers_blacklist = {
				-- prevent which key to open when A is used
				n = { "A" },
			},
		},
	},
}

return plugins
