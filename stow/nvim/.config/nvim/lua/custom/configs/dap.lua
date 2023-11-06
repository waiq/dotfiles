local dap = require("dap")

local mason_registry = require("mason-registry")

-- PHP debugging
-- install php-debug-adapter with mason
--
-- Set the following environment variables
-- SERVER_SOURCE_ROOT, abspath serverside folder
-- LOCAL_SOURCE_ROOT, abspath local dev folder
-- XDEBUG_SESSION, the session key
-- Suggestion: use .env file in the project folder
--
-- Setup XDebug
-- https://xdebug.org/docs/install
-- Example 20-xdebug.ini:
--[=====[ 

 zend_extension=xdebug.so
 xdebug.mode=develop,debug
 xdebug.start_with_request=yes
 xdebug.discover_client_host=1
 xdebug.log=/tmp/xdebug.log

 ;remote setup example
 xdebug.client_port=80
 xdebug.client_host="apps-server.dev.example.gov"

--]=====]

local php_debug_adapter_install_path = mason_registry.get_package("php-debug-adapter"):get_install_path()
local php_debug_launcher = vim.fn.glob(php_debug_adapter_install_path .. "/extension/out/phpDebug.js")

dap.adapters.php = {
	type = "executable",
	command = "node",
	-- args should contain the path to vscode-php-debug phpDebug.js file.
	args = { php_debug_launcher },
}

-- PHP debugging
dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9003,
		log = true,
	},
	{
		type = "php",
		request = "launch",
		name = "Remote debug port 9000",
		port = 9000,
		log = true,
		serverSourceRoot = os.getenv("SERVER_SOURCE_ROOT"),
		localSourceRoot = os.getenv("LOCAL_SOURCE_ROOT"),
	},
}

-- BASH debugging
local bash_debug_adapter_install_path = mason_registry.get_package("bash-debug-adapter"):get_install_path()
local bash_debug_launcher = vim.fn.glob(bash_debug_adapter_install_path .. "/bash-debug-adapter")

dap.adapters.bashdb = {
  type = 'executable';
  command = bash_debug_launcher;
  name = 'bashdb';
}

dap.configurations.sh = {
  {
    type = 'bashdb';
    request = 'launch';
    name = "Launch file";
    showDebugOutput = true;
    pathBashdb = vim.fn.glob(bash_debug_adapter_install_path .. '/extension/bashdb_dir/bashdb');
    pathBashdbLib = vim.fn.glob(bash_debug_adapter_install_path .. '/extension/bashdb_dir');
    trace = true;
    file = "${file}";
    program = "${file}";
    cwd = '${workspaceFolder}';
    pathCat = "cat";
    pathBash = "/bin/bash";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = {};
    env = {};
    terminalKind = "integrated";
  }
}
