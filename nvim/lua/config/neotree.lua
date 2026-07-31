local neotree = require('neo-tree')
neotree.setup({
  sources = { 'filesystem', 'buffers', 'git_status', 'tests' },
  source_selector = {
    winbar = true,
    sources = {
      { source = 'filesystem', display_name = '  ' },
      { source = 'buffers', display_name = ' 󱔘 ' },
      { source = 'git_status', display_name = '  ' },
      { source = 'tests', display_name = '  ' },
    },
  },
  tests = {
    window = {
      mappings = {
        ["<cr>"] = "toggle_node",
        o = "open",
      },
    },
  },
})

local function neotree_toggle()
  vim.cmd([[Neotree toggle]])
end

local function neotree_reveal_file()
  vim.cmd([[Neotree reveal]])
end

vim.keymap.set('n', '<leader>ee', neotree_toggle, {desc = 'NeoTree toggle'})
vim.keymap.set('n', '<leader>ef', neotree_reveal_file, {desc = 'NeoTree reveal file'})

require('which-key').add({
  {'<leader>ee'},
  {'<leader>ef'},
})
