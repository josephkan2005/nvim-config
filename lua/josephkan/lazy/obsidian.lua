return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    ui = { enable = false },
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
    },
  },
}
