require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = false,
    update_root = false,
  },
  git = {
    enable = true,
  },
  view = {
    adaptive_size = false,
    side = 'left',
    width = 30,
    preserve_window_proportions = true,
  },
  filesystem_watchers = { enable = true, },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = 'none',

    indent_markers = { enable = true },
  },
  filters = {
    dotfiles = true,
    git_ignored = true,
  },
  actions = {
    open_file = {
      resize_window = false,
    },
  },
}

vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', {})

local function open_nvim_tree()
  local tree = require('nvim-tree.api').tree
  local current_window = vim.api.nvim_get_current_win()
  tree.open()
  vim.api.nvim_set_current_win(current_window)
end

-- vim.api.nvim_create_autocmd({"VimEnter"}, { callback = open_nvim_tree })

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufnr = vim.api.nvim_win_get_buf(w)
      if vim.fn.buflisted(bufnr) == 0 then
        table.insert(invalid_win, w)
      end
    end

    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})

vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#ff8080" })

require('which-key').add({
  {'<leader>e', group = '󰙅 Tree'},
  {'<leader>ee', desc = 'Toggle tree'},
  {'<leader>ef', desc = 'Show current file in tree'},
})
