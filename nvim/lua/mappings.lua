-- Quick copy current line
vim.keymap.set('n', 'Y', 'yy')
-- Switch to last buffer
vim.keymap.set('n', '<C-e>', ':b# <CR>')

-- Quick exit to normal mode
vim.keymap.set('i', 'jk', '<esc>')

-- Delete current buffer
vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>')
-- Switch buffers
vim.keymap.set('n', '[b', ':bp<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bn<CR>', { silent = true })
vim.keymap.set('n', '<C-M-[>', ':bp<CR>', { silent = true })
vim.keymap.set('n', '<C-M-]>', ':bn<CR>', { silent = true })

-- Quick source current (Lua?) file
vim.keymap.set('n', '<leader>er', ':source %<CR>')

-- Shortcut to edit Vim config and re-read it
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<leader>es', ':source $MYVIMRC<CR>', { silent = true })
