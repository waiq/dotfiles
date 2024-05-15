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

lspconfig.rust_analyzer.setup({
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),
	settings = {
		["rust_analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})

-- generic servers
local servers = {
	"tsserver",
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
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
end
