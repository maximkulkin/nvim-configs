require('which-key').setup {
  plugins = {
    marks = true,
    registers = true,
    presets = {
      z = true,  -- fold actions help
      g = true,  -- misc actions (g) help
    },
  },
  show_help = true,
  show_keys = true,
  triggers = 'auto',
  triggers_nowait = {
    -- marks
    '`',
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    '<c-r>',
    -- 
  },
  triggers_blacklist = {
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}
