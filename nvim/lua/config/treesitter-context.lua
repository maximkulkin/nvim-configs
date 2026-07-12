local treesitter_context = require('treesitter-context')
treesitter_context.setup({
  enable = true,
  max_lines = 5,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = '-',
})

local function go_to_context()
  treesitter_context.go_to_context(vim.v.count1)
end

vim.keymap.set('n', '[c', go_to_context, {desc = 'Goto context'})

require('which-key').add({
  {'[c'},
})
