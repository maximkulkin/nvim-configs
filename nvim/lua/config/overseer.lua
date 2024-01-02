require('overseer').setup {}

vim.keymap.set("n", "<leader>rr", [[ :OverseerRun <CR> ]], {})
vim.keymap.set("n", "<leader>ro", [[ :OverseerOpen <CR> ]], {})

require('which-key').register({
  ['<leader>r'] = {
    r = 'Run command',
    o = 'List commands',
  },
})
