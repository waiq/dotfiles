local config = require("plugins.configs.lspconfig")

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- golang
lspconfig.gopls.setup({
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

-- terraform
lspconfig.terraformls.setup({})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- generic servers
local servers = {
	"ts_ls",
	"tailwindcss",
	"eslint",
	"phpactor",
	"bashls",
	"sqlls",
	"spectral",
	"ansiblels",
	"dockerls",
	"marksman",
	"cssls",
	"templ",
	"rubyls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
end
