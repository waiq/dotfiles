return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  ft = { 'rust' },
  dependencies = {
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap',
  },
  init = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>rh', '<cmd>RustLsp hover actions<CR>', { buffer = bufnr, desc = 'Rust hover actions' })
          vim.keymap.set('n', '<leader>ra', '<cmd>RustLsp codeAction<CR>', { buffer = bufnr, desc = 'Rust code action group' })
        end,
      },
    }
  end,
  config = function()
    require('mason-nvim-dap').setup {
      ensure_installed = { 'codelldb' },
    }
  end,
}
