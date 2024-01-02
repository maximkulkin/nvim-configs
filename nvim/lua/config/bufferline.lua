require('bufferline').setup {
  options = {
    close_command = 'Bdelete %d',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'left',
        separator = true,
      },
    },
    separator_style = 'slant',
  },
}
