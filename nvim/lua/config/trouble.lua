require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true, desc = 'Toggle trouble'})
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true, desc = 'Toggle trouble for workspace'})
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true, desc = 'Toggle trouble for document'})
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true, desc = 'Toggle trouble loclist'})
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true, desc = 'Toggle trouble quickfix'})
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true, desc = 'Toggle trouble LSP references'})

require('which-key').add({
  { '<leader>x', group = 'Trouble' },
  { '<leader>xw' },
  { '<leader>xd' },
  { '<leader>xl' },
  { '<leader>xq' },
  { 'gR' },
})
