local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end


local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local icons = require "configs.icons"

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warning },
	-- symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = true,
	always_visible = false,
}


local diff = {
	"diff",
	colored = true,
	symbols = { added = icons.git.Add, modified = icons.git.Mod, removed = icons.git.Remove }, -- changes diff symbols
	-- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width
}


local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}


local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}


local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}


local location = {
	"location",
	padding = 0,
}


-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end


local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end



lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diagnostics },
		lualine_c = { "filename" },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff },
		lualine_y = { "encoding", "fileformat", filetype },
		lualine_z = {  location, progress },
	},
	inactive_sections = {
		lualine_a = { branch },
		lualine_b = { "filename" },
		lualine_c = {},
		lualine_x = { filetype },
		lualine_y = { "location" },
		lualine_z = { progress },
	},
	tabline = {},
	extensions = {},
})
