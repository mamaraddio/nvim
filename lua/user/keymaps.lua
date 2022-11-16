local keymap = vim.keymap.set -- Shorten function name

local opts = { noremap = true, silent = true } -- Common options
-- local term_opts = { silent = true }

local M = {}

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

--Remap space as leader key
--[[ keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " " ]]

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
keymap("n", "<Space>f", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree
keymap("n", "<", "<0", opts) -- de-indent by pressing "<" once and stay in normal_mode
keymap("n", ">", ">0", opts) -- indent by pressing ">" once and stay in normal_mode
keymap("n", "<A-j>", ":m .+1<CR>", opts) -- Move text up
keymap("n", "<A-k>", ":m .-2<CR>", opts) -- Move text down
-- Telescope keybindings
-- keymap("n", "<Space>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<Space>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<Space>lg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "'", "<End>", opts) -- remap "'" as "$" to go at the end of the line
keymap("n", "<Space>q", "<cmd>lua require('settings.keymaps').smart_quit()<CR>", opts) -- force quit with <space>+q
keymap("n", "<Space>c", ":bdelete %<cr>", opts) -- close buffer with <space>+c
keymap("n", "<Space>w", ":w<cr>", opts) -- save with <space>+w
keymap("n", "<Space>x", ":x<cr>", opts) -- save and quit with <space>+x
-- keymap("n", "<Space>gph", ":Gitsigns preview_hunk<CR>", opts) -- Gitsigns
------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- Visual -------------------------------------------------------------------------
keymap("v", "<", "<gv", opts) -- de-indent by pressing "<" once and stay in visual_mode
keymap("v", ">", ">gv", opts) -- indent by pressing ">" once and stay in visual_mode
keymap("v", "<A-j>", ":m .+1<CR>", opts) -- Move text up
keymap("v", "<A-k>", ":m .-2<CR>", opts) -- Move text down
keymap("v", "p", '"_dP', opts)
keymap("v", "'", "$", opts) -- remap "'" as "$" to go at the end of the line
-- Gitsigns
-- keymap("v", "<Space>gph", ":Gitsigns preview_hunk<CR>", opts)
------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- Insert -------------------------------------------------------------------------
keymap("i", "<A-j>", "<ESC>:m .+1<CR>i", opts) -- Move text up
keymap("i", "<A-k>", "<ESC>:m .-2<CR>i", opts) -- Move text down
keymap("i", "<C-H>", "<Esc>ciw", opts) -- Delete word before the cursor
keymap("i", "<C-Del>", "<Esc>cw", opts) -- Delete word after the curso
------------------------------------------------------------------------------------------------------------------------------------------------

return M
