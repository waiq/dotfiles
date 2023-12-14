local null_ls = require("null-ls")
local autoformatting = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
	formatting.prettier,
	formatting.stylua,
	formatting.gofmt,
	formatting.goimports,
	formatting.golines,
	formatting.google_java_format,

	lint.codespell,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
