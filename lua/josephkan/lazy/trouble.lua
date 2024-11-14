local tagIdx = {}
local tags = {
  [0] = '',
  [1] = 'FIX',
  [2] = 'TODO',
  [3] = 'WARN',
  [4] = 'NOTE',
}
local numTags = 0
for key, value in pairs(tags) do
  tagIdx[value] = key
  numTags = numTags + 1
end

return {
  'folke/trouble.nvim',
  opts = {
    open_no_results = true,
    win = {
      size = 0.4,
    },
    ---@type table<string, trouble.Mode>
    modes = {
      todo = {
        mode = 'todo',
        keys = {
          s = {
            action = function(view)
              print(view.get()['mode'])
              local f = view:get_filter 'tag'
              local tag = tags[((tagIdx[f and f.filter.tag] or 0) + 1) % numTags]
              view:filter({ tag = tag }, {
                id = 'tag',
                template = '{hl:Title}Filter:{hl} {tag}',
                del = tag == '',
              })
            end,
            desc = 'Toggle Tag Filter',
          },
        },
      },
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
      '<cmd>Trouble todo toggle focus=true<cr>',
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
