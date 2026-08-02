require('nvim-treesitter').install({
  "bash", "c", "cmake", "cpp", "diff", "lua", "python",
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'c', 'cpp', 'python', 'markdown' },
  callback = function()
    vim.treesitter.start()
  end,
})

