local neotest = require("neotest")
neotest.setup({
  output = {
    enabled = true,
    open_on_run = false,
  },
  floating = {
    border = 'rounded',
    max_width = 0.6,
    max_height = 0.6,
    options = {},
  },
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
    }),
  },
  consumers = {
    neotree = require('neotest.consumers.neotree'),
    show_error = function(client)
      client.listeners.results = function(adapter_id, results, partial)
        if partial then return end

        local has_failure = false
        for pos_id, result in pairs(results) do
          if result.status == 'failed' then
            has_failure = true
            break
          end
        end

        if has_failure then
          vim.schedule(function()
            neotest.output.open({ enter = true, short = true })
          end)
        end
      end
    end,
  },
})

local neotest_namespace = vim.api.nvim_create_namespace('neotest')
vim.diagnostic.config({ virtual_text = true }, neotest_namespace)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neotest-output',
  callback = function(args)
    local win_id = vim.fn.bufwinid(args.buf)

    local neotest_close_output = function()
      if vim.api.nvim_win_is_valid(win_id) then
        vim.api.nvim_win_close(win_id, true)
      end
    end

    vim.keymap.set('n', 'q', neotest_close_output, { buffer = args.buf, silent = true, desc = 'Close test output' })

    require('which-key').add({
      { mode = 'n', buffer = args.buf },
      { 'q' },
    })
  end,
})

local function neotest_output()
  neotest.output.open({ enter = true, short = true })
end

local function neotest_run_file()
  neotest.run.run(vim.fn.expand('%'))
end

local function neotest_debug()
  neotest.run.run({ strategy = 'dap' })
end

vim.keymap.set('n', '<leader>tr', neotest.run.run, {noremap = true, silent = true, desc = 'Test run'})
vim.keymap.set('n', '<leader>tf', neotest_run_file, {noremap = true, silent = true, desc = 'Test run file'})
vim.keymap.set('n', '<leader>td', neotest_debug, {noremap = true, silent = true, desc = 'Test debug'})
vim.keymap.set('n', '<leader>ts', neotest.run.stop, {noremap = true, silent = true, desc = 'Test stop'})
vim.keymap.set('n', '<leader>to', neotest_output, {noremap = true, silent = true, desc = 'Test show output'})
vim.keymap.set('n', '<leader>tO', neotest.summary.toggle, {noremap = true, silent = true, desc = 'Test toggle summary'})

require('which-key').add({
  { '<leader>t', group = 'Test' },
  { '<leader>tr' },
  { '<leader>tf' },
  { '<leader>td' },
  { '<leader>ts' },
  { '<leader>to' },
  { '<leader>tO' },
})
