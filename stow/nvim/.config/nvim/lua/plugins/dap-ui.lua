return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap, dapui, widget = require 'dap', require 'dapui', require 'dap.ui.widgets'
    dapui.setup()

    vim.keymap.set('n', '<leader>dh', function()
      widget.hover()
    end, { desc = 'Dap window hover' })

    vim.keymap.set('n', '<leader>dp', function()
      widget.preview()
    end, { desc = 'Dap window preview' })

    vim.keymap.set('n', '<leader>df', function()
      widget.frame()
    end, { desc = 'Dap window frame' })

    vim.keymap.set('n', '<leader>ds', function()
      widget.scopes()
    end, { desc = 'Dap window scopes' })

    vim.keymap.set('n', '<leader>dw', function()
      dapui.toggle()
    end, { desc = 'Dap window open' })

    -- add listeners
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
