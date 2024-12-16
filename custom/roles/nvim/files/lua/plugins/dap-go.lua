return {
  'leoluz/nvim-dap-go',
  dependencies = {
    'mfussenegger/nvim-dap',
    'williamboman/mason.nvim',
  },
  ft = 'go',
  opts = {},
  config = function(_, opts)
    require('mason-nvim-dap').setup {
      ensure_installed = { 'delve' },
    }

    require('dap-go').setup(opts)
    vim.keymap.set('n', '<leader>dgt', function()
      require('dap-go').debug_test()
    end, { desc = 'Go run test' })

    vim.keymap.set('n', '<leader>dgl', function()
      require('dap-go').debug_last()
    end, { desc = 'Go run last test' })
  end,
}
