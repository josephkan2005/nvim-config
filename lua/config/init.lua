require('vim._core.ui2').enable()

require 'config.set'
require 'config.remap'
require 'config.lazy_init'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
