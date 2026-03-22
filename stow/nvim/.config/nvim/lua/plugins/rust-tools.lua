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
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = true,
            check = {
              command = 'clippy',
            },
          },
        },
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>rh', '<cmd>RustLsp hover actions<CR>', { buffer = bufnr, desc = 'Rust hover actions' })
          vim.keymap.set('n', '<leader>ra', '<cmd>RustLsp codeAction<CR>', { buffer = bufnr, desc = 'Rust code action group' })
          vim.keymap.set('n', '<leader>rr', '<cmd>RustLsp runnables<CR>', { buffer = bufnr, desc = 'Rust runnables' })
          vim.keymap.set('n', '<leader>rt', '<cmd>RustLsp testables<CR>', { buffer = bufnr, desc = 'Rust testables' })

          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
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
