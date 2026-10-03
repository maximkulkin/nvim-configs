local neotree = require('neo-tree')
local neotree_command = require('neo-tree.command')

neotree.setup({
  sources = { 'filesystem', 'buffers', 'git_status', 'tests', 'document_symbols' },
  source_selector = {
    winbar = true,
    sources = {
      { source = 'filesystem', display_name = '  ' },
      { source = 'buffers', display_name = ' 󱔘 ' },
      { source = 'git_status', display_name = '  ' },
      { source = 'tests', display_name = '  ' },
      { source = 'document_symbols', display_name = '  ' },
    },
  },
  window = {
    mappings = {
      q = "none",
      -- I = "inspect_node_data",
    },
  },
  tests = {
    window = {
      mappings = {
        ["<cr>"] = function(state)
          local node = state.tree:get_node()
          -- Check if node has children (is expandable/a directory)
          if require("neo-tree.utils").is_expandable(node) then
            state.commands["toggle_node"](state)
          else
            -- Otherwise treat it as a test/file and open it
            state.commands["open"](state)
          end
        end,
        o = "open",
        e = "noop",
        A = "noop",
        C = "noop",
        -- P = "noop",
        a = "noop",
        c = "noop",
        m = "noop",
        p = "noop",
        x = "noop",
        y = "noop",
      },
    },
  },
  commands = {
    inspect_node_data = function(state)
      local node = state.tree:get_node()
      if not node then
        print("No node selected")
        return
      end

      -- Open a scratch buffer to hold the pretty-printed table
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(buf, "ft", "lua")

      -- Pretty-print the node table into lines
      local dump = vim.inspect(node)
      local lines = {}
      for line in dump:gmatch("[^\r\n]+") do
        table.insert(lines, line)
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Open a floating window to view the inspect data easily
      vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = math.floor(vim.o.columns * 0.6),
        height = math.floor(vim.o.lines * 0.6),
        row = math.floor(vim.o.lines * 0.2),
        col = math.floor(vim.o.columns * 0.2),
        border = "rounded",
        title = " Node Data Inspector ",
        title_pos = "center",
      })
    end
  },
})

local function neotree_show_filesystem()
  neotree_command.execute({action = 'focus', source = 'filesystem'})
end

local function neotree_show_buffers()
  neotree_command.execute({action = 'focus', source = 'buffers'})
end

local function neotree_show_symbols()
  neotree_command.execute({action = 'focus', source = 'document_symbols'})
end

local function neotree_show_tests()
  neotree_command.execute({action = 'focus', source = 'tests'})
end

local function neotree_show_git_status()
  neotree_command.execute({action = 'focus', source = 'git_status'})
end

local function neotree_reveal_file()
  vim.cmd([[Neotree reveal]])
end

local function neotree_close()
  neotree_command.execute({action = 'close'})
end

vim.keymap.set('n', '<leader>ee', neotree_show_filesystem, {desc = 'NeoTree filesystem'})
vim.keymap.set('n', '<leader>eb', neotree_show_buffers, {desc = 'NeoTree buffers'})
vim.keymap.set('n', '<leader>eg', neotree_show_git_status, {desc = 'NeoTree git status'})
vim.keymap.set('n', '<leader>es', neotree_show_symbols, {desc = 'NeoTree symbols'})
vim.keymap.set('n', '<leader>et', neotree_show_tests, {desc = 'NeoTree tests'})
vim.keymap.set('n', '<leader>ef', neotree_reveal_file, {desc = 'NeoTree reveal file'})
vim.keymap.set('n', '<leader>ec', neotree_close, {desc = 'NeoTree close'})

require('which-key').add({
  {'<leader>ee'},
  {'<leader>ef'},
  {'<leader>eb'},
  {'<leader>eg'},
  {'<leader>es'},
  {'<leader>et'},
  {'<leader>ec'},
})
