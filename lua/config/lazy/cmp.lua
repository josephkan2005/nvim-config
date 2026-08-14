return {
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
  },
  build = function()
    require('blink.cmp').build():pwait()
  end,

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },

    completion = { documentation = { auto_show = true } },

    cmdline = {
      completion = { menu = { auto_show = false } },
    },

    snippets = { preset = 'luasnip' },

    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    fuzzy = { implementation = 'rust' },
  },
}
