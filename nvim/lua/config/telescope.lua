require('telescope').setup({
  defaults = {
    scroll_strategy = 'limit',
    layout_strategy = 'vertical',
    wrap_results = true,
    path_display = {
      shorten = {
        len = 3,
      },
    }
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fb', function() builtin.buffers({sort_mru = true }) end)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fw', builtin.grep_string)
vim.keymap.set('n', '<leader>fq', builtin.quickfix)
vim.keymap.set('n', '<leader>fl', builtin.loclist)
vim.keymap.set('n', '<leader>fr', builtin.registers)
vim.keymap.set('n', '<leader>fm', builtin.marks)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)

require('which-key').register({
  ['<leader>f'] = {
    name = ' Find',
    b = 'Buffers',
    f = 'Files',
    g = 'Grep',
    h = 'Help Tags',
    l = 'Loclist',
    m = 'Bookmarks',
    q = 'Quickfix',
    r = 'Registers',
    w = 'Word under cursor',
  },
})
