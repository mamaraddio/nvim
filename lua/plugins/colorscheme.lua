return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		init = function()
			vim.g.tokyonight_style = "storm"
			vim.g.tokyonight_italic_comments = false
			vim.cmd.colorscheme("tokyonight")
		end,
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
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1100,
		init = function()
			--[[ vim.api.nvim_set_hl(0, "FzfLuaBorder", {
				cterm = {
					italic = false,
				},
				fg = "#4e545f",
				italic = false,
			}) ]]
			-- vim.cmd.colorscheme("cyberdream")
		end,
		opts = {
			-- Enable transparent background
			transparent = false,

			-- Enable italics comments
			italic_comments = false,

			-- Replace all fillchars with ' ' for the ultimate clean look
			hide_fillchars = false,

			-- Modern borderless telescope theme - also applies to fzf-lua
			borderless_pickers = false,

			-- Set terminal colors used in `:terminal`
			terminal_colors = true,

			-- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
			cache = true,

			variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
			saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)
			highlights = {
				-- Highlight groups to override, adding new groups is also possible
				-- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

				-- Example:
				-- Comment = { fg = "#696969", bg = "NONE", italic = true },

				-- Complete list can be found in `lua/cyberdream/theme.lua`
			},

			-- Override a highlight group entirely using the color palette
			overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
				-- Example:
				return {
					Comment = { fg = colors.green, bg = "NONE", italic = true },
					["@property"] = { fg = colors.magenta, bold = true },
				}
			end,

			-- Override a color entirely
			colors = {
				-- For a list of colors see `lua/cyberdream/colours.lua`
				-- Example:
				bg = "#000000",
				green = "#00ff00",
				magenta = "#ff00ff",
			},

			-- Disable or enable colorscheme extensions
			extensions = {
				notify = true,
				mini = true,
			},
		},
	},
}
