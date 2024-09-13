return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'zathura_simple'
    vim.g.vimtex_quickfix_enabled = 0
  end,
}
