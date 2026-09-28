local group = vim.api.nvim_create_augroup('OcamlProjectTools', { clear = true })

local run_in_terminal = function(command)
  vim.cmd 'botright split'
  vim.cmd 'resize 12'
  vim.cmd('terminal ' .. command)
  vim.cmd 'startinsert'
end

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'ocaml', 'ocamlinterface', 'ocamllex', 'menhir' },
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'OCaml: ' .. desc })
    end

    map('<leader>ob', function()
      run_in_terminal 'dune build'
    end, 'Dune build')

    map('<leader>ot', function()
      run_in_terminal 'dune runtest'
    end, 'Dune runtest')

    map('<leader>oe', function()
      run_in_terminal 'dune exec -- cryptline'
    end, 'Dune exec cryptline')

    map('<leader>ou', function()
      run_in_terminal 'utop'
    end, 'Open utop')
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  pattern = { '*.ml', '*.mli', '*.mll', '*.mly' },
  callback = function(event)
    vim.lsp.buf.format {
      async = false,
      bufnr = event.buf,
      filter = function(client)
        return client.name == 'ocamllsp'
      end,
    }
  end,
})
