return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			-- javascript = { "prettier" },
			-- typescript = { "prettier" },
			-- css = { "prettier" },
			-- html = { "prettier" },
			-- json = { "prettier" },
			-- markdown = { "prettier" },
			-- python = { "isort", "black" },
			lua = { "stylua" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		},
	},
}
