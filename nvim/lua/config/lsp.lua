local lspconfig = require('lspconfig')

local on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
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

local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

vim.keymap.set('n', '<leader>vh', toggle_inlay_hints, { desc = 'Toggle inlay hints' })

vim.keymap.set({'n', 'i'}, '<C-S-i>', vim.lsp.buf.signature_help, {desc = 'Signature help'})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc = 'Goto Declaration'})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Goto Definition'})
vim.keymap.set('n', 'gri', vim.lsp.buf.incoming_calls, {desc = 'Goto incoming calls'})
vim.keymap.set('n', 'gro', vim.lsp.buf.outgoing_calls, {desc = 'Goto outgoing calls'})

vim.keymap.set('n', '[d', prev_diagnostic, {desc = 'Previous diagnostic'})
vim.keymap.set('n', ']d', next_diagnostic, {desc = 'Next diagnostic'})

require('which-key').add({
  {'[d'},
  {']d'},
  {'<C-S-i>'},
  {'<leader>vh'},

  {'g', group = 'Goto'},
  {'gD'},
  {'gd'},

  {'gra', desc = 'Execute code action'},
  {'grn', desc = 'Rename symbol'},
  {'grx', desc = 'Run codelens'},
  {'grr', desc = 'Goto references'},
  {'grt', desc = 'Goto type definition'},
  {'gri', desc = 'Goto implementation'},
})

local lua_runtime_paths = {}
for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  lua_runtime_paths[path] = true
end

vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
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
})

vim.lsp.config('clangd', {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    clangd = {
    },
  },
})

vim.lsp.config('cmake', {})

vim.lsp.config('basedpyright', {
  settings = {
    python = {
      pythonPath = vim.fn.exepath("python") or "python",
    },
    basedpyright = {
      autoSearchPaths = true,
      analysis = {
        autoImportCompletions = true,
        diagnosticMode = 'openFilesOnly',
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
        },
      },
    },
  },
})

vim.lsp.config('ts_ls', {})

vim.lsp.enable('basedpyright')
vim.lsp.enable('clangd')
vim.lsp.enable('cmake')
vim.lsp.enable('luals')
vim.lsp.enable('ts_ls')
