local notify = require('notify')

vim.keymap.set('n', '<leader>nd', function()
  notify.dismiss()
end, {noremap = true, silent = true})

require('which-key').register({
  ['<leader>nd'] = 'Notification dismiss',
})
