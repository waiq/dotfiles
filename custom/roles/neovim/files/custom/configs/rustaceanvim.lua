local rusti = require("rustaceanvim")
if not rusti then
	vim.notify("rustaceanvim not found")
	return
end

local mason_registry = require("mason-registry")

if not mason_registry then
	vim.notify("mason mason registry not found")
	return
end

local codelldb = mason_registry.is_installed("codelldb")
if not codelldb then
	vim.notify("codelldb not found, install with `:Mason install codelldb`")
	return
end

local extension_path = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"
local this_os = vim.uv.os_uname().sysname

liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

local cfg = require("rustaceanvim.config")
return {
	dap = {
		adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}
