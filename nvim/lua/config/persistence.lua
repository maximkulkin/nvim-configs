local persistence = require('persistence')
persistence.setup()

vim.keymap.set("n", "<leader>qs", persistence.save, {})
vim.keymap.set("n", "<leader>ql", persistence.load, {})
vim.keymap.set("n", "<leader>qe", persistence.start, {})
vim.keymap.set("n", "<leader>qd", persistence.stop, {})

require('which-key').register({
  ['<leader>q'] = {
    name = 'Session',
    s = 'Save session',
    l = 'Load session',
    e = 'Enable auto session',
    d = 'Disable auto session',
  },
})
