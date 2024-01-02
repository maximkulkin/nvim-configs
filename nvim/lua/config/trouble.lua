require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

require('which-key').register({
  ['<leader>x'] = {
    name = 'Trouble',
    x = 'Toggle trouble',
    w = 'Toggle trouble workspace',
    d = 'Toggle trouble document',
    l = 'Toggle trouble loclist',
    q = 'Toggle trouble quickfix',
  },
  ['gR'] = 'Toggle trouble LSP references',
})
