vim.g.mapleader = " "
vim.g.localleader = " "

vim.o.number = true
vim.o.relativenumber = true

local keymap = vim.keymap.set
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set mouse")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

keymap('n', '<Up>', '<Nop>', { noremap = true, silent = true })
keymap('n', '<Down>', '<Nop>', { noremap = true, silent = true })
keymap('n', '<Left>', '<Nop>', { noremap = true, silent = true })
keymap('n', '<Right>', '<Nop>', { noremap = true, silent = true })

keymap('v', '<Up>', '<Nop>', { noremap = true, silent = true })
keymap('v', '<Down>', '<Nop>', { noremap = true, silent = true })
keymap('v', '<Left>', '<Nop>', { noremap = true, silent = true })
keymap('v', '<Right>', '<Nop>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.exists(":Neotree") == 2 and vim.fn.argc() > 0 then
      vim.cmd("Neotree show") -- Открываем Neotree
    end
  end,
})

