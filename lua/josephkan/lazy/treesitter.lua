return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex' },
        additional_vim_regex_highlighting = { 'latex' },
      },
      indent = { enable = true },
    }

    require('nvim-treesitter.install').compilers = { 'clang' }

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, {
      pattern = { '*.vert', '*.frag', '*.comp', '*.geom', '*.tese', '*.tesc', '*.vs' },
      command = 'set filetype=glsl',
    })

    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, {
      pattern = { '*.cl' },
      command = 'set filetype=c',
    })
  end,
}
