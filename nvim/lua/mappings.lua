vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', '<C-e>', ':b# <CR>')
vim.keymap.set('n', 'E', ':e <C-R>=expand("%:h")<CR>/')

vim.keymap.set('i', 'jk', '<esc>')
