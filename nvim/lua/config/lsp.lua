local lspconfig = require('lspconfig')

local on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function list_workspace_folders()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local function rename_symbol()
  local old_name = vim.fn.expand('<cword>')
  local new_name = vim.fn.input('New name: ', old_name)
  vim.lsp.buf.rename(new_name)
end


local function prev_diagnostic()
  vim.diagnostic.jump({count = -1, float = true})
end

local function next_diagnostic()
  vim.diagnostic.jump({count = 1, float = true})
end

vim.keymap.set({'n', 'i'}, '<C-S-i>', vim.lsp.buf.signature_help, {desc = 'Signature help'})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {desc = 'Code actions'})
vim.keymap.set('n', '<leader>crr', rename_symbol, {desc = 'Rename symbol'})
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {desc = 'Add directory to workspace'})
vim.keymap.set('n', '<leader>wl', list_workspace_folders, {desc = 'List Workspace'})
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {desc = 'Remove directory from workspace'})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc = 'Goto Declaration'})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Goto Definition'})
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {desc = 'Goto Definition'})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {desc = 'Goto Implementation'})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = 'Goto References'})

vim.keymap.set('n', '[d', prev_diagnostic, {desc = 'Previous diagnostic'})
vim.keymap.set('n', ']d', next_diagnostic, {desc = 'Next diagnostic'})

require('which-key').add({
  {'[d'},
  {']d'},
  {'<C-S-i>'},

  {'<leader>c', group = 'Code'},
  {'<leader>ca'},
  {'<leader>crr'},

  {'<leader>w', group = 'Workspace'},
  {'<leader>wa'},
  {'<leader>wl'},
  {'<leader>wr'},

  {'g', group = 'Goto'},
  {'gD'},
  {'gd'},
  {'gt'},
  {'gi'},
  {'gr'},
})

local lua_runtime_paths = {}
for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  lua_runtime_paths[path] = true
end

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = lua_runtime_paths,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    clangd = {
    },
  },
}

lspconfig.cmake.setup {}

lspconfig.pylsp.setup {}
