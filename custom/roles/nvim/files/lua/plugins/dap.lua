return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    require('mason-nvim-dap').setup {
      ensure_installed = { 'python' },
    }

    vim.keymap.set('n', '<leader>dtt', function()
      require('dap').terminate()
    end, { desc = 'Dap terminate' })

    vim.keymap.set('n', '<leader>dc', function()
      require('dap').continue()
    end, { desc = 'Dap continue' })

    vim.keymap.set('n', '<leader>dr', function()
      require('dap').run_to_cursor()
    end, { desc = 'Dap run to cursor' })

    vim.keymap.set('n', '<leader>di', function()
      require('dap').step_into()
    end, { desc = 'Dap Step into' })

    vim.keymap.set('n', '<leader>dn', function()
      require('dap').step_over()
    end, { desc = 'Dap Step next' })

    vim.keymap.set('n', '<leader>do', function()
      require('dap').step_out()
    end, { desc = 'Dap Step out' })

    vim.keymap.set('n', '<leader>db', function()
      require('dap').toggle_breakpoint()
    end, { desc = 'Dap Toggle breakpoint' })
  end,
}
