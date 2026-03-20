return {
  'mfussenegger/nvim-dap-python',
  dependencies = {
    'mfussenegger/nvim-dap',
    'williamboman/mason.nvim',
  },
  ft = 'python',
  config = function()
    local mason_debugpy_python = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
    require('dap-python').setup(mason_debugpy_python)

    vim.keymap.set('n', '<leader>dpt', function()
      require('dap-python').test_method()
    end, { desc = 'Python debug test method' })

    vim.keymap.set('n', '<leader>dpc', function()
      require('dap-python').test_class()
    end, { desc = 'Python debug test class' })

    vim.keymap.set({ 'n', 'x' }, '<leader>dps', function()
      require('dap-python').debug_selection()
    end, { desc = 'Python debug selection' })

    vim.keymap.set('n', '<leader>dpf', function()
      local dap = require 'dap'
      local cfg = vim.deepcopy((dap.configurations.python or {})[1] or {})
      if not cfg.type then
        cfg.type = 'python'
        cfg.request = 'launch'
      end
      cfg.name = 'Python debug file'
      cfg.program = '${file}'
      dap.run(cfg)
    end, { desc = 'Python debug file' })
  end,
}
