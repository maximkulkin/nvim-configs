vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', '<C-e>', ':b# <CR>')
vim.keymap.set('n', 'E', ':e <C-R>=expand("%:h")<CR>/')

vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('n', '<leader>s', ':source %<CR>')

vim.keymap.set('n', '<C-M-[>', ':bp<CR>', { silent = true })
vim.keymap.set('n', '<C-M-]>', ':bn<CR>', { silent = true })

