local whichkey = require('which-key')
whichkey.setup {
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
  triggers = {
    { 'auto', mode = 'nxso' },
  },
  delay = function(ctx)
    return vim.tbl_contains({
      -- marks
      '`',
      "'",
      "g`",
      "g'",
      -- registers
      '"',
      '<c-r>',
    }, ctx.keys) and 0 or 300
  end,
  -- triggers_blacklist = {
  --   i = { 'j', 'k' },
  --   v = { 'j', 'k' },
  -- },
}

vim.keymap.set('n', '<leader>?', function()
  whichkey.show({global = false})
end, {})
