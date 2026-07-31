require('bufferline').setup {
  options = {
    close_command = 'Bdelete %d',
    offsets = {
      {
        filetype = 'neo-tree',
        text = '',
        text_align = 'center',
        separator = true,
      },
    },
    separator_style = 'slant',
  },
}
