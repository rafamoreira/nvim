return { 
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local filetypes = { 
      'bash', 
      'c', 
      'diff', 
      'html', 
      'lua', 
      'luadoc', 
      'markdown', 
      'markdown_inline', 
      'python', 
      'query', 
      'rust',
      'vim', 
      'vimdoc', 
      'typescript',
      'zig',
    }
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', { 
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })
  end,
}
