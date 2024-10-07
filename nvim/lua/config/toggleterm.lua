require("toggleterm").setup {
  direction = 'float',
}

vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>')

require('which-key').register({
  ['<leader>tt'] = 'Toggle terminal',
})
