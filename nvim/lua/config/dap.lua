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

local widgets = require('dap.ui.widgets')

local function show_frames()
  widgets.centered_float(widgets.frames)
end

vim.keymap.set('n', '<leader>dr', '<cmd>Telescope dap configurations<cr>', {desc = 'Debug run configuration'})
vim.keymap.set('n', '<leader>dR', dap.restart, {desc = 'Debug restart'})
vim.keymap.set('n', '<leader>dL', dap.run_last, {desc = 'Debug run last configuration'})
vim.keymap.set('n', '<leader>dt', dap.terminate, {desc = 'Debug terminate'})
vim.keymap.set('n', '<leader>dc', dap.continue, {desc = 'Debug continue'})
vim.keymap.set('n', '<leader>dj', dap.step_over, {desc = 'Debug step over (shortcut C-S-j)'})
vim.keymap.set('n', '<leader>dl', dap.step_into, {desc = 'Debug step into (shortcut C-S-l)'})
vim.keymap.set('n', '<leader>dk', dap.step_out, {desc = 'Debug step out (shortcut C-S-k)'})
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {desc = 'Debug toggle breakpoint'})
vim.keymap.set('n', '<leader>dB', dap.set_breakpoint, {desc = 'Debug set breakpoint'})
vim.keymap.set('n', '<leader>dE', dap.repl.toggle, {desc = 'Debug REPL toggle'})
vim.keymap.set({'n', 'v'}, '<leader>dp', widgets.preview, {desc = 'Debug preview value'})
vim.keymap.set('n', '<leader>df', show_frames, {desc = 'Debug show frames'})
vim.keymap.set('n', '<leader>du', dapui.toggle, {desc = 'Toggle Debug UI'})

-- Shortcuts for debug step execution
vim.keymap.set('n', '<C-S-j>', dap.step_over, {desc = 'Debug step over'})
vim.keymap.set('n', '<C-S-l>', dap.step_into, {desc = 'Debug step into'})
vim.keymap.set('n', '<C-S-k>', dap.step_out, {desc = 'Debug step out'})

require('which-key').add({
  {'<leader>d', group = 'Debug'},
  {'<leader>dr'},
  {'<leader>dR'},
  {'<leader>dL'},
  {'<leader>dc'},
  {'<leader>dt'},
  {'<leader>dj'},
  {'<leader>dk'},
  {'<leader>dl'},
  {'<leader>db'},
  {'<leader>dB'},
  {'<leader>dE'},
  {'<leader>df'},
  {'<leader>dp'},
  {'<leader>du'},

  {'<C-S-j>'},
  {'<C-S-k>'},
  {'<C-S-l>'},
})
