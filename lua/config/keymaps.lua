local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Space>", "", opts)

vim.keymap.set("n", "<C-i>", "<C-i>", opts)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-tab>", "<c-6>", opts)

vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("n", "<", "<<", opts) -- de-indent by pressing "<" once
vim.keymap.set("n", ">", ">>", opts) -- indent by pressing ">" once

vim.keymap.set("x", "p", [["_dP]])

-- vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
-- vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

-- vim.vim.keymap.set.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
-- vim.vim.keymap.set.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- more good
vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", opts)
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- tailwind bearable to work with
vim.keymap.set({ "n", "x" }, "j", "gj", opts)
vim.keymap.set({ "n", "x" }, "k", "gk", opts)
vim.keymap.set("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)
vim.keymap.set("t", "<C-;>", "<C-\\><C-n>", opts)

-- Move text up and down
vim.keymap.set({ "n", "v" }, "<A-j>", ":m .+1<CR>", opts)
vim.keymap.set({ "n", "v" }, "<A-k>", ":m .-2<CR>", opts)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>i", opts)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>i", opts)

-- Quit/Save NeoVim by vim.keymap.sets
vim.keymap.set("n", "<leader>q", ":q<cr>", opts)
vim.keymap.set("n", "<leader>Q", ":q!<cr>", opts)
vim.keymap.set("n", "<leader>w", ":w<cr>", opts)
vim.keymap.set("n", "<leader>x", ":x<cr>", opts)
