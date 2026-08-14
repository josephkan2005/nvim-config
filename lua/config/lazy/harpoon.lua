return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Add to Harpoon' })

    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():remove()
    end, { desc = 'Remove from Harpoon' })

    vim.keymap.set('n', '<leader>hw', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open Harpoon window' })

    vim.keymap.set('n', '<leader>h;', function()
      harpoon:list():select(1)
    end, { desc = 'Select first buffer' })

    vim.keymap.set('n', '<leader>hl', function()
      harpoon:list():select(2)
    end, { desc = 'Select second buffer' })

    vim.keymap.set('n', '<leader>hk', function()
      harpoon:list():select(3)
    end, { desc = 'Select third buffer' })

    vim.keymap.set('n', '<leader>hj', function()
      harpoon:list():select(4)
    end, { desc = 'Select fourth buffer' })

    vim.keymap.set('n', '<leader>ho', function()
      harpoon:list():select(5)
    end, { desc = 'Select fifth buffer' })

    vim.keymap.set('n', '<leader>hi', function()
      harpoon:list():select(6)
    end, { desc = 'Select sixth buffer' })

    vim.keymap.set('n', '<leader>hu', function()
      harpoon:list():select(7)
    end, { desc = 'Select seventh buffer' })

    vim.keymap.set('n', '<leader>hh', function()
      harpoon:list():select(8)
    end, { desc = 'Select eighth buffer' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = 'Go to previous buffer' })
    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = 'Go to next buffer' })
  end,
}
