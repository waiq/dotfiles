local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify("JDTLS not found, install with `:Mason install jdtls`")
	return
end

local mason_registry = require("mason-registry")

if not mason_registry.is_installed("java-debug-adapter") then
  vim.notify("java-debug-adapter not found, install with `:Mason install java-debug-adapter`")
  return
end

if not mason_registry.is_installed("java-test") then
  vim.notify("java-test not found, install with `:Mason install java-test`")
  return
end

local lspconfig = require("plugins.configs.lspconfig")

-- Installation location of jdtls by nvim-lsp-installer
local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local lombok = vim.fn.glob(jdtls_path .. "/lombok.jar")

local bundles = {}

-- Setup debug
local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1), "\n")
)
-- Setup test
local java_test_path = mason_registry.get_package("java-test"):get_install_path()
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

-- note: how to fix java_test Mason Issue 
-- clone https://github.com/microsoft/vscode-java-test into the mason install java-test path
-- run: 
-- npm i
-- npm run build-plugin
--
-- backup existing extension folder
--
-- run:
-- ln -s ./vscode-java-test extension
--

-- Data directory - change it to your liking
local home = os.getenv("HOME")
local workspace_path = home .. "/.cache/jdtls/workspace"

-- Setup Workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. "/" .. project_name

-- os_config for Linux and Mac
local os_config = jdtls_path .. "/" .. "config_linux"
if vim.fn.has("mac") == 1 then
	os_config = jdtls_path .. "/" .. "config_mac"
end

-- setup project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	vim.notify("JDTLS problem setup root_dir")
	return
end

-- capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local on_attach = function(client, bufnr)
	lspconfig.on_attach(client, bufnr)

	vim.lsp.codelens.refresh()
	jdtls.setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()
	require("jdtls.setup").add_commands()

	local map = function(mode, lhs, rhs, desc)
		if desc then
			desc = desc
		end
		vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
	end

	-- Register keymappings
	local wk = require("which-key")
	local keys = { mode = { "n", "v" }, ["<leader>lj"] = { name = "+Java" } }
	wk.register(keys)

	map("n", "<leader>ljo", jdtls.organize_imports, "Organize Imports")
	map("n", "<leader>ljv", jdtls.extract_variable, "Extract Variable")
	map("n", "<leader>ljc", jdtls.extract_constant, "Extract Constant")
	map("n", "<leader>ljt", jdtls.test_nearest_method, "Test Nearest Method")
	map("n", "<leader>ljT", jdtls.test_class, "Test Class")
	map("n", "<leader>lju", "<cmd>JdtUpdateConfig<cr>", "Update Config")
	map("v", "<leader>ljv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable")
	map("v", "<leader>ljc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant")
	map("v", "<leader>ljm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method")

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.java" },
		callback = function()
			-- auto command to refresh the code lens whenever a Java file is saved.
			local _, _ = pcall(vim.lsp.codelens.refresh)
		end,
	})
end

local config = {

	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	--
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok,
		"-jar",
		launcher,
		"-configuration",
		os_config,
		"-data",
		workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	capabilities = lspconfig.capabilities,
	on_attach = on_attach,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			autobuild = { enabled = false },
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			saveActions = {
				organizeImports = true,
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			eclipse = {
				downloadSources = true,
			},

			configuration = {
				updateBuildConfiguration = "interactive",
				-- NOTE: Add the available runtimes here
				-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
				-- runtimes = {
				--   {
				--     name = "JavaSE-18",
				--     path = "~/.sdkman/candidates/java/18.0.2-sem",
				--   },
				-- },
				--
				--
				runtimes = {
					{
						name = "JavaSE-17",
						path = "~/.sdkman/candidates/java/17.0.2-open",
					},
					{
						name = "JavaSE-11",
						path = "~/.sdkman/candidates/java/11.0.12-open",
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
			-- NOTE: We can set the formatter to use different styles
			-- format = {
			--   enabled = true,
			--   settings = {
			--     url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
			--     profile = "GoogleStyle",
			--   },
			-- },
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java" },
	desc = "Setup jdtls",
	callback = function()
		-- This starts a new client & server,
		-- or attaches to an existing client & server depending on the `root_dir`.
		jdtls.start_or_attach(config)
	end,
})
