local lsp = {
	function()
		local bufnr = vim.api.nvim_get_current_buf()
		local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
		if #buf_clients == 0 then
			return "LSP Inactive"
		end

		local buf_ft = vim.bo.filetype
		local buf_client_names = {}
		local copilot_active = false

		-- add client
		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" and client.name ~= "copilot" then
				table.insert(buf_client_names, client.name)
			end

			if client.name == "copilot" then
				copilot_active = true
			end
		end

		-- add formatter
		local formatters = require("lvim.lsp.null-ls.formatters")
		local supported_formatters = formatters.list_registered(buf_ft)
		vim.list_extend(buf_client_names, supported_formatters)

		-- add linter
		local linters = require("lvim.lsp.null-ls.linters")
		local supported_linters = linters.list_registered(buf_ft)
		vim.list_extend(buf_client_names, supported_linters)

		local unique_client_names = table.concat(buf_client_names, ", ")
		local language_servers = string.format("[%s]", unique_client_names)

		if copilot_active then
			language_servers = language_servers
				.. "%#SLCopilot#"
				.. " "
				.. require("config..icons").git.Octoface
				.. "%*"
		end

		return language_servers
	end,
	color = { gui = "bold" },
}
local scrollbar = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		return chars[index]
	end,
	padding = { left = 0, right = 0 },
	-- color = "SLProgress",
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = "",
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = {
				{
					"branch",
				},
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
				{
					"diagnostics",
				},
			},
			lualine_c = { --[[ "filename" ]]
			},
			lualine_x = { "fileformat", "filetype" },
			lualine_y = {
				-- lsp,
				lsp,
				{
					"copilot",
					show_colors = true,
					separator = { right = "" },
				},
			},
			lualine_z = { scrollbar },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {
			"quickfix",
			"man",
			"mason",
			"lazy",
			"nvim-dap-ui",
			"symbols-outline",
			"toggleterm",
			"trouble",
		},
	},
}
