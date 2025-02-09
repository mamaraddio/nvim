vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = true                         -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 100                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = false                  -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.foldenable = true                       -- enable fold
vim.opt.foldlevel = 99                          -- start editing with all folds opened
vim.opt.foldmethod = "expr"                     -- use tree-sitter for folding method
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.treesitter.language.register("bash", "zsh")
vim.opt.pumblend = 10
vim.opt.laststatus = 3
vim.opt.showcmd = true
vim.opt.ruler = false
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 8
vim.opt.title = false
vim.opt.confirm = true
--colorcolumn = "80",
-- colorcolumn = "120",

vim.opt.fillchars:append({
	stl = " ",
	eob = " ",
})

vim.opt.shortmess:append({ c = true })

vim.opt.whichwrap:append({
	["<"] = true,
	[">"] = true,
	["["] = true,
	["]"] = true,
	b = true,
	h = true,
	l = true,
	s = true,
})

vim.opt.iskeyword:append("-")

vim.api.nvim_set_hl(0, "@comment", {
	cterm = {
		italic = false,
	},
	fg = 6986069,
	italic = false,
})

vim.opt.formatoptions:append({
	c = false,
	r = false,
	o = false,
})

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
