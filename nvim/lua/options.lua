vim.g.mapleader = '\\'

-- Disable default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.colorcolumn = "85"
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"

vim.opt.laststatus = 3
vim.opt.showmode = true

vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

-- disable nvim intro
vim.opt.shortmess:append "sI"

vim.opt.termguicolors = true
vim.opt.timeoutlen = 400

vim.opt.mouse = 'a'

vim.opt.cinoptions = 'l1'

-- aliases for commonly mistyped commands
vim.cmd([[command! Q q]])
vim.cmd([[command! W w]])
-- replace standard "bdelete" with a Bdelete from bufdelete plugin
vim.cmd([[command! Bd Bdelete]])
vim.cmd([[cabbrev bd Bdelete]])

-- do not show quickfix in list of buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- auto reload changed configs
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.tbl_map(
    vim.fs.normalize,
    vim.fn.glob(vim.fn.stdpath 'config' .. '/lua/**/*.lua', true, true, true)
  ),
  callback = function(opts)
    local fp = vim.fn.fnamemodify(vim.gs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ':r')
    local module = string.gsub(fp, '^.*/nvim/lua/', ''):gsub('/', '.')

    require('plenary.reload').reload_module(module)
  end,
})
