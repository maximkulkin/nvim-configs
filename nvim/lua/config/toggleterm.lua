require("toggleterm").setup {
  direction = 'float',
}

vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', {desc = 'Toggle terminal'})

require('which-key').add({
  {'<leader>tt'},
})
