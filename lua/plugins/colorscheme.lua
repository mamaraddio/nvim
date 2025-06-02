return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			styles = {
				comments = { italic = false },
			},
		},
		init = function() vim.cmd.colorscheme("tokyonight") end,
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		init = function()
			-- vim.cmd.colorscheme("eldritch")
		end,
	},
	{
		"LunarVim/darkplus.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		init = function()
			-- vim.cmd.colorscheme("darkplus")
		end,
	},
}
