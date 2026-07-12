return {
  name = 'run',
  desc = 'Run current file',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      cmd = { file },
      components = { 'default' },
    }
  end,
  -- condition = {
  --   callback = function()
  --     if vim.fn.executable(vim.fn.expand('%')) then
  --       return false, 'File is not executable'
  --     end
  --     return true
  --   end,
  -- },
}

