return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		sync_install = false,
		ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "python" },
		auto_install = true,
		ignore_install = {},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		modules = {},
	},
}
