local lspimport = require('lspimport')

vim.keymap.set("n", "<leader>ci", lspimport.import, {noremap = true, desc = 'Import symbol'})

require('which-key').add({
  {'<leader>ci'},
})
