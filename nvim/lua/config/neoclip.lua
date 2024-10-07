require('neoclip').setup({})
require('telescope').load_extension('neoclip')

vim.keymap.set('n', '<leader>fp', ':Telescope neoclip<CR>')

require('which-key').register({
  ['<leader>fp'] = 'Paste from yank history',
})
