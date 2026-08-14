return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'

    npairs.setup {
      check_ts = true,
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'", '`' },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    }

    npairs.add_rule(Rule('<', '>', {
      '-html',
      '-javascriptreact',
      '-typescriptreact',
    }):with_pair(cond.before_regex('%a+:?:?$', 3)):with_move(function(opts)
      return opts.char == '>'
    end))

    npairs.add_rules {
      Rule('$', '$', { 'tex', 'latex' })
        -- don't add a pair if the next character is %
        :with_pair(cond.not_after_regex '%%')
        -- don't move right when repeat character
        :with_move(cond.done())
        -- don't delete if the next character is xx
        :with_del(cond.done())
        -- disable adding a newline when you press <cr>
        :with_cr(cond.done()),
    }
  end,
  opts = {},
}
