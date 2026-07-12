require('neoclip').setup({})
require('telescope').load_extension('neoclip')

local function NeoClip()
  vim.cmd('Telescope neoclip')
end

vim.keymap.set('n', '<leader>fp', NeoClip, {desc = 'Paste from yank history'})

require('which-key').add({
  {'<leader>fp'},
})
