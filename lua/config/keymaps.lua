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
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
vim.keymap.set("n", "<", "<<", { desc = "Indent left" }) -- de-indent by pressing "<" once
vim.keymap.set("n", ">", ">>", { desc = "Indent right" }) -- indent by pressing ">" once

vim.keymap.set("x", "p", [["_dP]])

-- vim.vim.keymap.set.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
-- vim.vim.keymap.set.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- more good
vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", { desc = "Go to start of line" })
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Go to end of line" })

--[[ -- tailwind bearable to work with
vim.keymap.set({ "n", "x" }, "j", "gj", opts)
vim.keymap.set({ "n", "x" }, "k", "gk", opts)
vim.keymap.set("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)
vim.keymap.set("t", "<C-;>", "<C-\\><C-n>", opts) ]]

-- Move text up and down
vim.keymap.set({ "n", "v" }, "<A-j>", ":m .+1<CR>", opts)
vim.keymap.set({ "n", "v" }, "<A-k>", ":m .-2<CR>", opts)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>i", opts)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>i", opts)

-- Quit/Save NeoVim by vim.keymap.sets
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })
-- vim.keymap.set("n", "<leader>Q", vim.cmd.quit({bang = true }), { desc = "Force Quit" })
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>x", ":x<cr>", { desc = "Save and Quit" })
