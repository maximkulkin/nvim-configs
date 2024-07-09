local dap, dapui = require('dap'), require('dapui')
local mason_registry = require('mason-registry')

dap.adapters.python = {
  type = 'executable';
  command = '/opt/homebrew/bin/python3';
  args = { '-m', 'debugpy.adapter' };
}


dap.adapters.codelldb = function(on_config, _, _)
  local codelldb_root = mason_registry.get_package('codelldb'):get_install_path()
  local codelldb_path = codelldb_root .. '/codelldb'
  local liblldb_path = codelldb_root .. '/extension/lldb/lib/liblldb.dylib'
  local config = {
    type = 'server',
    port = '${port}',
    host = '127.0.0.1',
    executable = {
      command = codelldb_path,
      args = { '--liblldb', liblldb_path, '--port', '${port}' },
      -- args = { '--port', '${port}' },
    },
  }
  vim.print('config = ', config)
  on_config(config)
end

dap.configurations.c = {
  {
    name = 'run',
    type = 'codelldb',
    request = 'launch',
    program = function()
      local path = vim.fn.input({
        prompt = 'Path to executable: ',
        default = vim.fn.getcwd() .. '/',
        completion = 'file',
      })
      return (path and path ~= '') and path or dap.ABORT
    end,
  },
}

dap.configurations.cpp = {
  {
    name = 'run',
    type = 'codelldb',
    request = 'launch',
    program = function()
      local path = vim.fn.input({
        prompt = 'Path to executable: ',
        default = vim.fn.getcwd() .. '/',
        completion = 'file',
      })
      return (path and path ~= '') and path or dap.ABORT
    end,
  },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
  },
}

dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

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
