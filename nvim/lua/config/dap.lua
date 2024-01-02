local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  command = '/opt/homebrew/bin/python3';
  args = { '-m', 'debugpy.adapter' };
}

vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dn', dap.step_over)
vim.keymap.set('n', '<leader>ds', dap.step_into)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dB', dap.set_breakpoint)
vim.keymap.set('n', '<leader>dl', dap.run_last)
vim.keymap.set({'n', 'v'}, '<leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)

require('which-key').register({
  ['<leader>d'] = {
    c = 'Debug continue',
    s = 'Debug step into',
    n = 'Debug step over',
    b = 'Debug toggle breakpoint',
    B = 'Debug set breakpoint',
    r = 'Debug run',
    l = 'Debug run last',
    p = 'Debug preview value',
    f = 'Debug show frames',
  },
})
