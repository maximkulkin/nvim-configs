local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

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
    find_files = {
      mappings = {
        i = {
          ['<C-b>'] = function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local current_dir = current_picker.cwd

            actions.close(prompt_bufnr)

            telescope.extensions.file_browser.file_browser({
              cwd = current_dir,
            })
          end,
        },
      },
    },
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
    file_browser = {
      mappings = {
        i = {
          -- Pressing <C-f> in file_browser switches to find_files
          ["<C-b>"] = function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)

            -- IMPORTANT: Using file_browser's internal state to find the folder 
            -- you are actively looking at (not just the root project directory)
            local current_dir = current_picker.finder.path

            actions.close(prompt_bufnr)

            require("telescope.builtin").find_files({
              cwd = current_dir,
            })
          end,
        },
      },
    },
    ['ui-select'] = {
    },
  },
})

telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')
local file_browser = telescope.extensions.file_browser.file_browser

local function telescope_notifications()
  vim.cmd('Telescope notify')
end

local function file_browse_packer()
  file_browser({cwd = vim.fs.joinpath(vim.fn.stdpath('data'), "site/pack/packer")})
end

local function file_browse_here()
  -- file_browser({cwd = vim.fn.expand('%:h')})
  builtin.find_files({cwd = vim.fn.expand('%:h')})
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Files'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Buffers'})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {desc = 'Command history'})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {desc = 'Diagnostics'})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {desc = 'Live grep'})
vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {desc = 'Git branches'})
vim.keymap.set('n', '<leader>fgc', builtin.git_commits, {desc = 'Git commits'})
vim.keymap.set('n', '<leader>fgs', builtin.git_status, {desc = 'Git status'})
vim.keymap.set('n', '<leader>fgt', builtin.git_stash, {desc = 'Git stash'})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc = 'Find word under cursor'})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {desc = 'Quickfix'})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc = 'Keymaps'})
vim.keymap.set('n', '<leader>fl', builtin.loclist, {desc = 'Loclist'})
vim.keymap.set('n', '<leader>fr', builtin.registers, {desc = 'Registers'})
vim.keymap.set('n', '<leader>fm', builtin.marks, {desc = 'Marks'})
vim.keymap.set('n', '<leader>fn', telescope_notifications, {desc = 'Notifications'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Help tags'})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {desc = 'Search history'})
vim.keymap.set('n', '<leader>f-', builtin.resume, {desc = 'Last search'})
vim.keymap.set('n', '<leader>fE', file_browse_here, {desc = 'Find file in the same directory as current file'})

vim.keymap.set('n', '<leader>ec', function() builtin.find_files({cwd = vim.fn.stdpath('config')}) end, {desc = 'Fine file in Neovim config'})
vim.keymap.set('n', '<leader>ep', file_browse_packer, {desc = 'Find file in Neovim plugins directory'})

require('which-key').add({
  {'<leader>f', group = ' Find'},
  {'<leader>f-'},
  {'<leader>f/'},
  {'<leader>fb'},
  {'<leader>fc'},
  {'<leader>fd'},
  {'<leader>ff'},
  {'<leader>fs'},
  {'<leader>fg', group = 'Git'},
  {'<leader>fgb'},
  {'<leader>fgc'},
  {'<leader>fgs'},
  {'<leader>fgt'},
  {'<leader>fh'},
  {'<leader>fk'},
  {'<leader>fl'},
  {'<leader>fm'},
  {'<leader>fn'},
  {'<leader>fq'},
  {'<leader>fr'},
  {'<leader>fw'},
  {'<leader>ec'},
  {'<leader>ep'},
})
