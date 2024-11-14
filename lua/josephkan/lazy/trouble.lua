return {
  'folke/trouble.nvim',
  opts = {
    open_no_results = true,
    win = {
      size = 0.4,
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>te',
      '<cmd>Trouble diagnostics toggle focus=true<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>to',
      '<cmd>Trouble todo toggle focus=true filter = {tag = {TODO,FIX,FIXME}}<cr>',
      desc = 'Todo (Trouble)',
    },
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle focus=true<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>ti',
      '<cmd>Trouble lsp toggle focus=true win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>tl',
      '<cmd>Trouble loclist toggle focus=true<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>tq',
      '<cmd>Trouble qflist toggle focus=true<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
}
