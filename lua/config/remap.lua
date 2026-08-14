vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>ev', vim.cmd.Explore, { desc = 'Open Netrw' })

vim.keymap.set('n', '<C-w>d', function()
  vim.diagnostic.open_float { border = 'solid' }
end, { desc = 'Show diagnostic [E]rror messages' })

vim.keymap.set('n', '<leader>xx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'chmod +x' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
