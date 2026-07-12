local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
    }),
  },
})

vim.api.nvim_create_user_command('NeotestRun', neotest.run.run, {})
vim.api.nvim_create_user_command('NeotestRunFile', function()
  neotest.run.run(vim.fn.expand('%'))
end, {})
vim.api.nvim_create_user_command('NeotestRunLast', neotest.run.run_last, {})
vim.api.nvim_create_user_command('NeotestStop', neotest.run.stop, {})
vim.api.nvim_create_user_command('NeotestOutput', neotest.output.open, {})
vim.api.nvim_create_user_command('NeotestSummaryToggle', neotest.summary.toggle, {})


vim.keymap.set('n', '<leader>tr', ':NeotestRun<CR>', {noremap = true, silent = true, desc = 'Test run'})
vim.keymap.set('n', '<leader>ts', ':NeotestStop<CR>', {noremap = true, silent = true, desc = 'Test stop'})
vim.keymap.set('n', '<leader>to', ':NeotestOutput<CR>', {noremap = true, silent = true, desc = 'Test show output'})
vim.keymap.set('n', '<leader>tf', ':NeotestRunFile<CR>', {noremap = true, silent = true, desc = 'Test run file'})
vim.keymap.set('n', '<leader>tl', ':NeotestRunLast<CR>', {noremap = true, silent = true, desc = 'Test run last'})
vim.keymap.set('n', '<leader>tO', ':NeotestSummaryToggle<CR>', {noremap = true, silent = true, desc = 'Test show panel'})

require('which-key').add({
  { '<leader>tr' },
  { '<leader>ts' },
  { '<leader>to' },
  { '<leader>tf' },
  { '<leader>tl' },
})
