return {
	{
		"fang2hou/blink-copilot",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			opts = {
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = {
					markdown = true,
				},
			},
		},
	},
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "rafamadriz/friendly-snippets", lazy = true },
			{ "xzbdmw/colorful-menu.nvim", lazy = true, config = true },
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		---@return blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "enter",
			},
			completion = {
				-- 'prefix' will fuzzy match on the text before the cursor
				-- 'full' will fuzzy match on the text before *and* after the cursor
				-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
				keyword = { range = "prefix" },

				-- Disable auto brackets
				-- NOTE: some LSPs may add auto brackets themselves anyway
				accept = { auto_brackets = { enabled = true } },

				-- Insert completion item on selection, don't select by default
				-- list = { selection = 'auto_insert' },
				-- or set per mode
				list = {
					selection = {
						preselect = true,
						auto_insert = true,
					},
				},
				menu = {
					auto_show = true,
					border = "rounded",
					draw = {
						align_to = "cursor",
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", gap = 1 },
							{ "label", "kind", gap = 1 },
						},
						components = {
							label = {
								---@param ctx blink.cmp.DrawItemContext
								text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
								---@param ctx blink.cmp.DrawItemContext
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
							kind_icon = {
								ellipsis = false,
								---@param ctx blink.cmp.DrawItemContext
								text = function(ctx)
									if ctx.kind == "Copilot" then return "" end
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								---@param ctx blink.cmp.DrawItemContext
								highlight = function(ctx)
									if ctx.kind == "Copilot" then return "MiniIconsCyan" end
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 300,
					treesitter_highlighting = true,
				},
				ghost_text = { enabled = false },
			},
			cmdline = {
				enabled = true,
				completion = {
					menu = { auto_show = true },
					list = {
						selection = {
							preselect = true,
							auto_insert = true,
						},
					},
				},
			},
			sources = {
				default = {
					"lazydev",
					"copilot",
					"lsp",
					"path",
					"buffer",
					"snippets",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 150,
					},
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},
			-- Experimental signature help support
			signature = {
				enabled = true,
			},
		},
		opts_extend = { "sources.default" },
	},
}
