local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap



--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
------------------------------------
keymap("n", "<leader>f", ":NvimTreeToggle<CR>", opts)	-- Toggle NvimTree
keymap("n", "<", "<<", opts)							-- de-indent by pressing "<" once
keymap("n", ">", ">>", opts)							-- indent by pressing ">" once
-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>", opts)
keymap("n", "<A-k>", ":m .-2<CR>", opts)
----------------------------------------------
-- Telescope keybindings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", opts)
----------------------------------------------
-- Quit/Save NeoVim by keymaps
keymap("n", "<leader>q", ":q<cr>", opts)		-- quit with <space>+q
keymap("n", "<leader>qq", ":q!<cr>", opts)		-- force quit with <space>+qq
keymap("n", "<leader>w", ":w<cr>", opts)		-- save with <space>+w
keymap("n", "<leader>x", ":x<cr>", opts)		-- save and quit with <space>+x
-- Gitsigns
keymap("n", "<leader>gph", ":Gitsigns preview_hunk<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>", opts)
keymap("v", "<A-k>", ":m .-2<CR>", opts)
-- Gitsigns
keymap("v", "<leader>gph", ":Gitsigns preview_hunk<CR>", opts)
----------------------------------------------

-- Insert --
-- Move text up and down
keymap("i", "<A-j>", "<Esc>:m .+1<CR>i", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>i", opts)
----------------------------------------------
