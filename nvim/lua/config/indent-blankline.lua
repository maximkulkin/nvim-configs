-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append 'tab:>-'

local highlight = {
  "CursorColumn",
  "Whitespace",
}

require('ibl').setup {
  indent = {
    highlight = highlight,
    char = "",
  },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = {
    enabled = true,
  },
  --show_current_context = true,
  --show_current_context_start = true,
  --show_trailing_blankline_indent = false,
  --char = "",
  --char_highlight_list = {
  --  "IndentBlanklineIndent1",
  --  "IndentBlanklineIndent2",
  --},
  --space_char_highlight_list = {
  --  "IndentBlanklineIndent1",
  --  "IndentBlanklineIndent2",
  --},
}
