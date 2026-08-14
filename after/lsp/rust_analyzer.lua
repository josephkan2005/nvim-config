return {
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
}
