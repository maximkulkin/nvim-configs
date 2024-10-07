local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup({
  defaults = {
    scroll_strategy = 'limit',
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
    },
    wrap_results = true,
    path_display = {
      shorten = {
        len = 3,
      },
    },
    history = {},
    mappings = {
      i = {
        ['<S-Down>'] = actions.cycle_history_next,
        ['<S-Up>'] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    buffers = {
      sort_mru = true,
      bufnr_width = 2,
      mappings = {
        i = {
          ['<c-x>'] = 'delete_buffer',
        },
        n = {
          d = 'delete_buffer',
          ['<c-x>'] = 'delete_buffer',
        },
      }
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fc', builtin.command_history)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fw', builtin.grep_string)
vim.keymap.set('n', '<leader>fq', builtin.quickfix)
vim.keymap.set('n', '<leader>fl', builtin.loclist)
vim.keymap.set('n', '<leader>fr', builtin.registers)
vim.keymap.set('n', '<leader>fm', builtin.marks)
vim.keymap.set('n', '<leader>fn', [[:Telescope notify<CR>]])
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>f/', builtin.search_history)
vim.keymap.set('n', '<leader>f-', builtin.resume)

require('which-key').register({
  ['<leader>f'] = {
    name = ' Find',
    b = 'Buffers',
    c = 'Command history',
    d = 'Diagnostics',
    f = 'Files',
    g = 'Grep',
    h = 'Help Tags',
    l = 'Loclist',
    m = 'Bookmarks',
    n = 'Notifications',
    q = 'Quickfix',
    r = 'Registers',
    w = 'Word under cursor',
    ['/'] = 'Search history',
    ['-'] = 'Last search',
  },
})
