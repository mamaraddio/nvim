local keymap = vim.keymap.set -- Shorten function name

local opts = { noremap = true, silent = true } -- Common options
-- local term_opts = { silent = true }

local M = {}

function M.smart_save()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname == "" then
		vim.ui.input({
			prompt = "Name of the new buffer: ",
		}, function(input)
			if input ~= nil then
				vim.cmd("w " .. input)
			else
				vim.notify("Unable to save. No name provided", "warn", { title = "SmartSave" })
			end
		end)
	else
		vim.cmd("w")
	end
end

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	local bufname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
	if modified then
		local answer =
			vim.fn.confirm('You have unsaved changes to "' .. bufname .. '". Quit anyway?', "&No\n&yes\n&save")
		if answer == 2 then
			vim.cmd("q!")
		elseif answer == 3 then
			require("user.keymaps").smart_savequit()
		else
			vim.notify("There are unsaved canges", "warn", { title = "SmartQuit" })
		end
	else
		vim.cmd("q")
	end
end

function M.smart_savequit()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname == "" then
		vim.ui.input({
			prompt = "Name of the new buffer: ",
		}, function(input)
			if input ~= nil then
				vim.cmd("x " .. input)
			else
				vim.notify("Unable to save. No name provided", "warn", { title = "SmartSaveQuit" })
			end
		end)
	else
		vim.cmd("x")
	end
end

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

--------------------------------------------------------------- Normal -------------------------------------------------------------------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
--
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +3<CR>", opts)
keymap("n", "<C-Down>", ":resize -3<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +3<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -3<CR>", opts)
--
keymap("n", "--", ":noh<CR>", opts) -- Toggle NvimTree
keymap("n", "<leader>f", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree
keymap("n", "<", "<0", opts) -- de-indent by pressing "<" once and stay in normal_mode
keymap("n", ">", ">0", opts) -- indent by pressing ">" once and stay in normal_mode
keymap("n", "<A-j>", ":m .+1<CR>", opts) -- Move text up
keymap("n", "<A-k>", ":m .-2<CR>", opts) -- Move text down
-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "'", "<End>", opts) -- remap "'" as "$" to go at the end of the line
keymap("n", "<leader>q", "<cmd>lua require('user.keymaps').smart_quit()<CR>", opts) -- force quit with <leader>+q
keymap("n", "<leader>c", ":bdelete %<cr>", opts) -- close buffer with <leader>+c
keymap("n", "<leader>w", "<cmd>lua require('user.keymaps').smart_save()<CR>", opts) -- save with <leader>+w
-- keymap("n", "<leader>w", ":w<cr>", opts) -- save with <leader>+w
keymap("n", "<leader>x", "<cmd>lua require('user.keymaps').smart_savequit()<CR>", opts) -- save with <leader>+x
-- keymap("n", "<leader>x", ":x<cr>", opts) -- save and quit with <leader>+x
-- keymap("n", "<leader>gph", ":Gitsigns preview_hunk<CR>", opts) -- Gitsigns
------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- Visual -------------------------------------------------------------------------
keymap("v", "<", "<gv", opts) -- de-indent by pressing "<" once and stay in visual_mode
keymap("v", ">", ">gv", opts) -- indent by pressing ">" once and stay in visual_mode
keymap("v", "<A-j>", ":m .+1<CR>", opts) -- Move text up
keymap("v", "<A-k>", ":m .-2<CR>", opts) -- Move text down
keymap("v", "p", '"_dP', opts)
keymap("v", "'", "$", opts) -- remap "'" as "$" to go at the end of the line
-- Gitsigns
-- keymap("v", "<leader>gph", ":Gitsigns preview_hunk<CR>", opts)
------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- Insert -------------------------------------------------------------------------
keymap("i", "<A-j>", "<ESC>:m .+1<CR>i", opts) -- Move text up
keymap("i", "<A-k>", "<ESC>:m .-2<CR>i", opts) -- Move text down
keymap("i", "<C-H>", "<Esc>ciw", opts) -- Delete word before the cursor
keymap("i", "<C-Del>", "<Esc>cw", opts) -- Delete word after the curso
------------------------------------------------------------------------------------------------------------------------------------------------

return M
