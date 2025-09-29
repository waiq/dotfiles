return {
  'mistweaverco/kulala.nvim',
  -- keys = {
  --   { '<leader>Rs', desc = 'Send request' },
  --   { '<leader>Ra', desc = 'Send all requests' },
  --   { '<leader>Rb', desc = 'Open scratchpad' },
  -- },
  ft = { 'http', 'rest' },
  opts = {
    ui = {
      max_response_size = 1024 * 1024, -- 1MB
    },
    -- your configuration comes here
    global_keymaps = true,

    vim.filetype.add {
      extension = {
        ['http'] = 'http',
      },
    },
  },
}
