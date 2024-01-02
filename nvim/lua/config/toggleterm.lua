require("toggleterm").setup {
  direction = 'float',
}

vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')

require('which-key').register({
  ['<leader>t'] = 'Toggle terminal',
})
