require('neoclip').setup()
require('telescope').load_extension('neoclip')

vim.keymap.set('n', '<leader>p', ':Telescope neoclip "<CR>')

require('which-key').register({
  ['<leader>p'] = 'Paste from yank history',
})
