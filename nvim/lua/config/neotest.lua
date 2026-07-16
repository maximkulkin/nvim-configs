local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
    }),
  },
})

local function neotest_output()
  neotest.output.open({ enter = true })
end

local function neotest_run_file()
  neotest.run.run(vim.fn.expand('%'))
end

vim.api.nvim_create_user_command('NeotestRun', neotest.run.run, {})
vim.api.nvim_create_user_command('NeotestRunFile', neotest_run_file, {})
vim.api.nvim_create_user_command('NeotestRunLast', neotest.run.run_last, {})
vim.api.nvim_create_user_command('NeotestStop', neotest.run.stop, {})
vim.api.nvim_create_user_command('NeotestOutput', neotest_output, {})
vim.api.nvim_create_user_command('NeotestSummaryToggle', neotest.summary.toggle, {})



vim.keymap.set('n', '<leader>tr', ':NeotestRun<CR>', {noremap = true, silent = true, desc = 'Test run'})
vim.keymap.set('n', '<leader>tf', ':NeotestRunFile<CR>', {noremap = true, silent = true, desc = 'Test run file'})
vim.keymap.set('n', '<leader>tl', ':NeotestRunLast<CR>', {noremap = true, silent = true, desc = 'Test run last'})
vim.keymap.set('n', '<leader>ts', ':NeotestStop<CR>', {noremap = true, silent = true, desc = 'Test stop'})
vim.keymap.set('n', '<leader>to', ':NeotestOutput<CR>', {noremap = true, silent = true, desc = 'Test show output'})
vim.keymap.set('n', '<leader>tO', ':NeotestSummaryToggle<CR>', {noremap = true, silent = true, desc = 'Test toggle summary'})

require('which-key').add({
  { '<leader>t', group = 'Test' },
  { '<leader>tr' },
  { '<leader>ts' },
  { '<leader>to' },
  { '<leader>tf' },
  { '<leader>tl' },
})
