return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    { 'j-hui/fidget.nvim', opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    } },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, modes)
          vim.keymap.set(modes or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

        map('grr', require('telescope.builtin').lsp_references, 'Goto References')

        map('gri', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

        map('grt', require('telescope.builtin').lsp_type_definitions, 'Type Definition')

        map('grd', vim.lsp.buf.declaration, 'Goto Declaration')

        map('<leader>sc', require('telescope.builtin').lsp_document_symbols, '[S]earch [C]urrent Buffer Symbols')

        map('<leader>sp', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [P]roject Symbols')

        map('K', function()
          vim.lsp.buf.hover { border = 'solid' }
        end, 'Hover Documentation')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    require('mason').setup()

    local ensure_installed = vim.tbl_keys {}

    vim.list_extend(ensure_installed, {
      'stylua',
    })

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
    }
  end,
}
