require('nvim-treesitter.configs').setup {
  ensure_installed = { "awk", "bash", "c", "cmake", "cpp", "diff", "lua", "python" },
  auto_install = true,
  sync_install = false,
  ignore_install = {},
  modules = {},
}
