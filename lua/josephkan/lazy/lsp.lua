return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

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
        if client and client.name == 'typescript-tools' then
          local ns = vim.lsp.diagnostic.get_namespace(client.id)

          -- vim.diagnostic.disable(nil, ns)
        end
      end,
    })

    ---@type table<string, lspconfig.Config>
    local servers = {
      --[[ eslint = {
        settings = {
          workingDirectory = {
            mode = 'auto',
          },
          format = { enable = true },
          lint = { enable = true },
        },
      }, ]]
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              kubernetes = { '/kube/*.yml', '/kube/*.yaml' },
            },
          },
        },
      },
      verible = {
        cmd = {
          'verible-verilog-ls',
          '--rules_config=.verible-lint-rules',
        },
      },
      jdtls = {
        settings = {
          java = {
            configuration = {},
            symbols = {
              includeSourceMethodDeclarations = true,
            },
          },
        },
      },
      rust_analyzer = {
        on_attach = function(_, bufnr)
          local expand_macro = function(ctx)
            local create_floating_win = function(response)
              if response == nil or response[1] == nil or response[1].result == nil then
                return
              end
              local focus = false
              if ctx.args and string.find(ctx.args, 'focus') then
                focus = true
              end
              local num_lines = 0
              local longest_line = 0
              local lines = {}
              for s in string.gmatch(response[1].result.expansion, '[^\r\n]+') do
                table.insert(lines, s)
                longest_line = math.max(longest_line, string.len(s))
                num_lines = num_lines + 1
              end
              local buf = vim.api.nvim_create_buf(false, true)
              local win_opts = {
                relative = 'cursor',
                width = longest_line + 2,
                height = num_lines,
                col = 0,
                row = 1,
                anchor = 'NW',
                style = 'minimal',
                border = 'solid',
              }
              vim.api.nvim_set_option_value('filetype', 'rust', { buf = buf })
              vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
              local win = vim.api.nvim_open_win(buf, focus, win_opts)
              if not focus then
                local augroup = vim.api.nvim_create_augroup('preview_window_' .. win, {
                  clear = true,
                })
                vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufHidden' }, {
                  group = augroup,
                  callback = function()
                    vim.api.nvim_win_close(win, true)
                    vim.api.nvim_clear_autocmds { group = augroup }
                  end,
                })
              end
            end
            vim.lsp.buf_request_all(0, 'rust-analyzer/expandMacro', vim.lsp.util.make_position_params(0, 'utf-8'), create_floating_win)
          end
          vim.api.nvim_buf_create_user_command(bufnr, 'LspExpandMacro', expand_macro, { nargs = '?' })
        end,
      },
      gopls = {
        settings = {
          env = {
            GOFLAGS = '-tags=test',
          },
        },
      },
      clangd = {
        filetypes = { 'c', 'cpp' },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
    }

    require('typescript-tools').setup {
      settings = {
        expose_as_code_action = { 'all' },
        implicitProjectConfiguration = {
          checkJs = true,
        },
      },
    }

    for server_name, server in pairs(servers) do
      vim.lsp.config(server_name, server)
      vim.lsp.enable(server_name)
    end

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, {
      'stylua',
    })

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
    }
  end,
}
