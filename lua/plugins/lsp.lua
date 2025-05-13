return {
	{
		"mason-org/mason.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = { ui = { border = "rounded" } },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"vimls",
			},
			automatic_installation = { exclude = { "rust_analyzer" } },
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason.nvim", "mfussenegger/nvim-lint", "stevearc/conform.nvim" },
		opts = function()
			--[[ local formatters = {}
			vim.iter(vim.tbl_values(require("conform").formatters_by_ft)):flatten():map(function(formatter)
				if not vim.list_contains(formatters, formatter) then table.insert(formatters, formatter) end
			end)
			local linters = {}
			vim.iter(vim.tbl_values(require("lint").linters_by_ft)):flatten():map(function(linter)
				if not vim.list_contains(linters, linter) then table.insert(linters, linter) end
			end)

			local list = vim.list_extend(formatters, linters)
			vim.print(list)

			return {
				ensure_installed = list,
				auto_update = true,
			} ]]
		end,
	},
	{
		"folke/lazydev.nvim",
		event = { "BufRead", "BufNewFile" },
		ft = "lua", -- only load on lua files
		opts = {
			--- See the configuration section for more details
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- Load luvit types when the `vim.uv` word is found
				vim.api.nvim_get_runtime_file("", true),
			},
		},
		config = true,
	},
	-- { "folke/neoconf.nvim", config = true },
	{ "neovim/nvim-lspconfig", enable = false },
}
