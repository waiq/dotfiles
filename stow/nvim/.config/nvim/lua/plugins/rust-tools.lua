return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  ft = { 'rust' },
  dependencies = {
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap',
  },
  init = function()
    local rust_format_augroup = vim.api.nvim_create_augroup('RustFormatOnSave', { clear = true })

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

          vim.api.nvim_clear_autocmds { group = rust_format_augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = rust_format_augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                bufnr = bufnr,
                filter = function(client)
                  return client.name == 'rust_analyzer' or client.name == 'rust-analyzer'
                end,
              }
            end,
          })

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
