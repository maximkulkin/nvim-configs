local gitsigns = require('gitsigns')

local function gitsigns_next_hunk()
  gitsigns.nav_hunk('next')
end

local function gitsigns_prev_hunk()
  gitsigns.nav_hunk('prev')
end

local function gitsigns_stage_selected_lines()
  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end

local function gitsigns_reset_selected_lines()
  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end

local function gitsigns_setqflist_all()
  gitsigns.setqflist('all')
end

gitsigns.setup({
  signcolumn = true,
  auto_attach = true,
  on_attach = function()
    vim.keymap.set('n', '[h', gitsigns_prev_hunk, {expr = true, desc = 'Git previous hunk'})
    vim.keymap.set('n', ']h', gitsigns_next_hunk, {expr = true, desc = 'Git next hunk'})

    vim.keymap.set('n', '<leader>ghs', gitsigns.stage_hunk, {expr = true, desc = 'Git stage hunk'})
    vim.keymap.set('n', '<leader>ghr', gitsigns.reset_hunk, {expr = true, desc = 'Git reset hunk'})

    vim.keymap.set('v', '<leader>ghs', gitsigns_stage_selected_lines, {expr = true, desc = 'Git stage selected lines'})
    vim.keymap.set('v', '<leader>ghr', gitsigns_reset_selected_lines, {expr = true, desc = 'Git reset selected lines'})

    vim.keymap.set('n', '<leader>ghS', gitsigns.stage_buffer, {expr = true, desc = 'Git stage hunk'})
    vim.keymap.set('n', '<leader>ghR', gitsigns.reset_buffer, {expr = true, desc = 'Git reset hunk'})

    vim.keymap.set('n', '<leader>gq', gitsigns.setqflist, {expr = true, desc = 'Show document hunks'})
    vim.keymap.set('n', '<leader>gQ', gitsigns_setqflist_all, {expr = true, desc = 'Show all hunks'})

    vim.keymap.set('n', '<leader>gd', gitsigns.preview_hunk, {expr = true, desc = 'Show hunk preview'})
    vim.keymap.set('n', '<leader>gi', gitsigns.preview_hunk_inline, {expr = true, desc = 'Show hunk preview inline'})

    require('which-key').add({
      {'[h'},
      {']h'},

      {'<leader>g', group = 'Git', icon = ''},
      {'<leader>ghs'},
      {'<leader>ghr'},

      {'<leader>ghs'},
      {'<leader>ghr'},

      {'<leader>ghS'},
      {'<leader>ghR'},

      {'<leader>gq'},
      {'<leader>gQ'},

      {'<leader>gd'},
      {'<leader>gi'},

    })
  end,
})
