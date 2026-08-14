local workspaces = {
  {
    name = 'personal',
    path = '~/vaults/personal',
  },
}

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  -- ft = 'markdown',
  cond = function()
    for _, workspace in ipairs(workspaces) do
      local vault_path = vim.fn.expand(workspace.path)
      local cwd = vim.fn.getcwd()

      if vim.startswith(cwd, vault_path) then
        return true
      end
    end
    return false
  end,

  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    ui = { ignore_conceal_warn = true },
    workspaces = workspaces,
  },
}
