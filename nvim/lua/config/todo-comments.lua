local todo = require('todo-comments')
todo.setup({
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = {
      icon = ' ',
      color = 'error',
      alt = { 'FIXME', 'BUG', 'FIXIT' },
    },
    TODO = { icon = ' ', color = 'info' },
    HACK = { icon = ' ', color = 'warning' },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
  },
  highlight = {
    multiline = true, -- enable multine todo comments
    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
})

local function trouble_todo_comments()
  vim.cmd([[Trouble todo]])
end

vim.keymap.set('n', ']t', todo.jump_next, {desc = 'Next TODO comment'})
vim.keymap.set('n', '[t', todo.jump_prev, {desc = 'Previous TODO comment'})
vim.keymap.set('n', '<leader>xt', trouble_todo_comments, {desc = 'Trouble TODO'})

require('which-key').add({
  {']t'},
  {'[t'},
  {'<leader>xt', icon = ''},
})
