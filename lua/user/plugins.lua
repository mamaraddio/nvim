local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	git = {
		clone_timeout = 180,
	},
	max_jobs = nil,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins goes here --------------------------------------------------------------------------------------------------------------------

	use("wbthomason/packer.nvim")									-- Have packer manage itself
	use("nvim-lua/popup.nvim")										-- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim")									-- Useful lua functions used by lots of plugins
	use("lewis6991/impatient.nvim")									-- Speedup NeoVim loading times
	-- use("kyazdani42/nvim-web-devicons")								-- File icons
	-- use("rcarriga/nvim-notify")										-- Notification manager
	-- use("audibleblink/hackthebox.vim")								-- HackTheBox colorscheme
	use("martinsione/darkplus.nvim")
	-- use("folke/tokyonight.nvim")
	-- use("numToStr/Comment.nvim")									-- Easily comment stuff
	-- use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })	-- Syntax Highlighting engine
	-- use("p00f/nvim-ts-rainbow")
	-- use("windwp/nvim-ts-autotag")
	-- use("windwp/nvim-autopairs")
	-- use("JoosepAlviste/nvim-ts-context-commentstring")				-- TreeSitter context commentstring
	-- use("kyazdani42/nvim-tree.lua")									-- File explorer
	-- use({ "akinsho/bufferline.nvim", requires = "moll/vim-bbye" })	-- Enable bufferline
	-- use("nvim-lualine/lualine.nvim")
	-- use("lukas-reineke/indent-blankline.nvim")
	-- use("akinsho/toggleterm.nvim")
	-- use("lewis6991/gitsigns.nvim")
	-- use("gelguy/wilder.nvim")										-- Better `wildmenu` (even command palette)
	-- use("neovim/nvim-lspconfig")									-- Enable LSP
	-- use("williamboman/mason.nvim")									-- LSP installer
	-- use("williamboman/mason-lspconfig.nvim")						-- Mason bindings for lspconfig
	-- use("jose-elias-alvarez/null-ls.nvim")							-- Null Language Server (for linters and formatters)
	-- use("RRethy/vim-illuminate")									-- Highlights the word under the cursor
	-- -- cmp plugins
	-- use("hrsh7th/nvim-cmp")											-- The completion plugin
	-- use("hrsh7th/cmp-buffer")										-- buffer completions
	-- use("hrsh7th/cmp-path")											-- path completions
	-- use("saadparwaiz1/cmp_luasnip")									-- snippet completions
	-- use("hrsh7th/cmp-nvim-lsp")
	-- use({"hrsh7th/cmp-nvim-lua",
		-- ft = "lua",
	-- })
	-- -- snippets
	-- use("L3MON4D3/LuaSnip")											--snippet engine
	-- use("rafamadriz/friendly-snippets")								-- a bunch of snippets to use
	-- use({"iamcco/markdown-preview.nvim",							-- Preview markdown document
		-- opt = true,
		-- run = "cd app && npm install",
		-- setup = function()
			-- vim.g.mkdp_filetypes = { "markdown" }
		-- end,
		-- ft = { "markdown" },
	-- })

	--------------------------------------------------------------------------------------------------------------------------------------------
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
