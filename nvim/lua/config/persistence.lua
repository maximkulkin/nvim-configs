local persistence = require('persistence')
persistence.setup()

vim.keymap.set("n", "<leader>qs", persistence.save, {desc = 'Session save'})
vim.keymap.set("n", "<leader>ql", persistence.load, {desc = 'Session load'})
vim.keymap.set("n", "<leader>qe", persistence.start, {desc = 'Session auto enable'})
vim.keymap.set("n", "<leader>qd", persistence.stop, {desc = 'Session auto disable'})

require('which-key').add({
  {'<leader>q', group = 'Session'},
  {'<leader>qe'},
  {'<leader>qd'},
  {'<leader>ql'},
  {'<leader>qs'},
})
