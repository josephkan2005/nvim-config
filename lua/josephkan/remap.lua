vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', '<leader>ev', vim.cmd.Explore, { desc = 'Open Netrw' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>p', '"0p')
vim.keymap.set('n', '<leader>P', '"0P')

vim.keymap.set('n', '<C-Up>', '<C-w>-')
vim.keymap.set('n', '<C-Down>', '<C-w>+')
vim.keymap.set('n', '<C-Left>', '<C-w><')
vim.keymap.set('n', '<C-Right>', '<C-w>>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>er', function()
  vim.diagnostic.open_float { border = 'solid' }
end, { desc = 'Show diagnostic [E]rror messages' })

vim.keymap.set('n', '<leader>xx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'chmod +x' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
