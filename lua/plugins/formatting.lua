local luacmd = require("utils").luacmd

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			bash = { "beautysh" },
			css = { "prettierd" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			jsx = { "prettierd" },
			markdown = { "prettierd" },
			scss = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			zsh = { "beautysh" },
		},
		default_format_opts = {
			lsp_format = "fallback",
			async = true,
		},
		format_on_save = { timeout_ms = 500, async = false },
		-- Customize formatters
		formatters = {
			beautysh = {
				prepend_args = { "--force-function-style", "fnpar" },
			},
		},
	},
	init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
}
