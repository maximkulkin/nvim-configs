local cmp = require('cmp')

local function if_cmp(fn, ...)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      fn(unpack(arg))
    else
      fallback()
    end
  end, {'i', 'c'})
end

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  enabled = true,
  completion = {
    keyword_length = 1,
  },
  preselect = cmp.PreselectMode.None,
  view = {
    docs = {
      auto_open = true,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  mapping = {
    ['<C-k>'] = if_cmp(cmp.select_prev_item),
    ['<C-j>'] = if_cmp(cmp.select_next_item),
    ['<C-b>'] = if_cmp(cmp.scroll_docs, -4),
    ['<C-f>'] = if_cmp(cmp.scroll_docs, 4),
    ['<C-h>'] = if_cmp(cmp.abort),
    ['<C-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      else
        cmp.complete()
      end
    end, {'i', 'c'}),
    ['<C-g>'] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
  },
}

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources(
    {
      { name = 'path' },
    },
    {
      { name = 'cmdline' },
    }
  ),
})

cmp.setup.filetype('neorepl', {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
})

