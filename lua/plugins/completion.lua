return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"xzbdmw/colorful-menu.nvim",
		{
			"giuxtaposition/blink-cmp-copilot",
			dependencies = {
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				opts = {
					suggestion = { enabled = false },
					panel = { enabled = false },
				},
			},
		},
	},

	-- use a release tag to download pre-built binaries
	version = "*",
	-- version = '0.9.0',
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	---@return blink.cmp.Config
	opts = function()
		local colorful_menu = require("colorful-menu")
		return {
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
				accept = { auto_brackets = { enabled = false } },

				-- Insert completion item on selection, don't select by default
				-- list = { selection = 'auto_insert' },
				-- or set per mode
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},

				menu = {
					-- Don't automatically show the completion menu
					auto_show = true,
					border = "rounded",

					-- nvim-cmp style menu
					-- draw = {
					--   columns = {
					--     { "label",     "label_description", gap = 1 },
					--     { "kind_icon", "kind" }
					--   },
					-- }
					draw = {
						align_to = "cursor",
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", gap = 1 },
						},
						components = {
							label = {
								text = colorful_menu.blink_components_text,
								highlight = colorful_menu.blink_components_highlight,
							},
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									if ctx.kind == "Copilot" then
										return ""
									end
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									if ctx.kind == "Copilot" then
										return "MiniIconsGreen"
									end
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},

				-- Show documentation when selecting a completion item
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					treesitter_highlighting = true,
					window = { border = "rounded" },
				},

				-- Display a preview of the selected item on the current line
				ghost_text = { enabled = false },
			},

			sources = {
				-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
				},
				-- Disable cmdline completions
				-- cmdline = {},
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			-- Experimental signature help support
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
		}
	end,
	opts_extend = { "sources.default" },
}
