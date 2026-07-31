require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true, desc = 'Trouble menu'})
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics<cr>", {silent = true, noremap = true, desc = 'Trouble diagnostics'})
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true, desc = 'Toggle trouble loclist'})
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true, desc = 'Toggle trouble quickfix'})

require('which-key').add({
  { '<leader>x', group = 'Trouble' },
  { '<leader>xd' },
  { '<leader>xl' },
  { '<leader>xq' },
})
