return {
  'simrat39/rust-tools.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('mason-nvim-dap').setup {
      ensure_installed = { 'codelldb' },
    }
    local rt = require 'rust-tools'
    rt.setup {
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set('n', '<leader>rh', rt.hover_actions.hover_actions, { buffer = bufnr, desc = 'Rust hover actions' })
          -- Code action groups
          vim.keymap.set('n', '<leader>ra', rt.code_action_group.code_action_group, { buffer = bufnr, desc = 'Rust code action group' })
        end,
      },
    }
  end,
}
