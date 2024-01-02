local lualine = require('lualine')

lualine.setup {
  sections = {
    lualine_b = {},
    lualine_c = { {'filename', path = 1}, require('lsp-progress').progress },
    lualine_z = { 'location' },
  },
}

-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = 'lualine_augroup',
  pattern = 'LspProgressStatusUpdated',
  callback = lualine.refresh,
})

