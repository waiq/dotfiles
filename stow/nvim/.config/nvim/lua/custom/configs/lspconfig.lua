local config = require("plugins.configs.lspconfig")

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- golang
lspconfig.gopls.setup({
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	cmd = { "gopls" },
	filetype = { "go", "gomod", "gowork", "gotmpl" },
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

-- generic servers
local servers = {
	"tsserver",
	"phpactor",
	"bashls",
	"sqlls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
end
