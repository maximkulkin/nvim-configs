require('treesitter-context').setup {
  enable = true,
  max_lines = 5,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = '-',
}
