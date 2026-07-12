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

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Files'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Buffers'})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {desc = 'Command history'})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {desc = 'Diagnostics'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = 'Grep'})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc = 'Find word under cursor'})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {desc = 'Quickfix'})
vim.keymap.set('n', '<leader>fl', builtin.loclist, {desc = 'Loclist'})
vim.keymap.set('n', '<leader>fr', builtin.registers, {desc = 'Registers'})
vim.keymap.set('n', '<leader>fm', builtin.marks, {desc = 'Marks'})
vim.keymap.set('n', '<leader>fn', [[:Telescope notify<CR>]], {desc = 'Notifications'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Help tags'})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {desc = 'Search history'})
vim.keymap.set('n', '<leader>f-', builtin.resume, {desc = 'Last search'})

vim.keymap.set('n', '<leader>ec', function() builtin.find_files({cwd = vim.fn.stdpath('config')}) end, {desc = 'Fine file in Neovim config'})

require('which-key').add({
  {'<leader>f', group = ' Find'},
  {'<leader>f-'},
  {'<leader>f/'},
  {'<leader>fb'},
  {'<leader>fc'},
  {'<leader>fd'},
  {'<leader>ff'},
  {'<leader>fg'},
  {'<leader>fh'},
  {'<leader>fl'},
  {'<leader>fm'},
  {'<leader>fn'},
  {'<leader>fq'},
  {'<leader>fr'},
  {'<leader>fw'},
  {'<leader>ec'},
})
