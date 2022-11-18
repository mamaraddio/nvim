local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
return
end

local navic_ok, navic = pcall(require, "nvim-navic")
  if not navic_ok then
    return
  end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local icons = require "user.icons"

local filename = {
	'filename',
	file_status = true,      -- Displays file status (readonly status, modified status)
	newfile_status = true,   -- Display new file status (new file means no write after created)
	path = 3,                -- 0: Just the filename
							-- 1: Relative path
							-- 2: Absolute path
							-- 3: Absolute path, with tilde as the home directory
	shorting_target = 40,    -- Shortens path to leave 40 spaces in the window for other components. (terrible name, any suggestions?)
	symbols = {
		-- modified = '[+]',      -- Text to show when the file is modified.
		-- readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
		modified = icons.ui.Pencil,      -- Text to show when the file is modified.
		readonly = icons.ui.Lock,      -- Text to show when the file is non-modifiable or readonly.
		unnamed = icons.documents.File, -- Text to show for unnamed buffers.
		newfile = icons.ui.NewFile,     -- Text to show for new created file before first writting
	}
}

local buffers = {
	'buffers',
	show_filename_only = true,   -- Shows shortened relative path when set to false.
	hide_filename_extension = false,   -- Hide filename extension when set to true.
	show_modified_status = true, -- Shows indicator when the buffer is modified.
	mode = 0, -- 0: Shows buffer name
			-- 1: Shows buffer index
			-- 2: Shows buffer name + buffer index
			-- 3: Shows buffer number
			-- 4: Shows buffer name + buffer number
	max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component, it can also be a function that returns the value of `max_length` dynamically.
	filetype_names = {
		TelescopePrompt = 'Telescope',
		dashboard = 'Dashboard',
		packer = 'Packer',
		fzf = 'FZF',
		alpha = 'Alpha'
	}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

	-- buffers_color = {
	-- -- Same values as the general color option can be used here.
	-- 	active = 'lualine_{section}_normal',     -- Color for active buffer.
	-- 	inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
	-- },

	symbols = {
		modified = ' ' .. icons.ui.Pencil,      -- Text to show when the buffer is modified
		alternate_file = '#', -- Text to show to identify the alternate file
		directory =  icons.documents.Folder,     -- Text to show when the buffer is a directory
	},
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = {
		error = icons.diagnostics.Error,
		warn = icons.diagnostics.Warning,
		info = icons.diagnostics.Information,
		hint = icons.diagnostics.Hint
	},
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
		-- return "-- " .. str .. " --"
		return str
	end,
}

local searchcount = {
	"searchcount",
	fmt = function(str)
		return string.sub(str, 2, string.len(str)-1)
	end,
	colored = true,
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

lualine.setup({
	options = {
		globalstatus = true,
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
		lualine_c = { filename },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff },
		lualine_y = { searchcount, "fileformat", "encoding", filetype, progress },
		lualine_z = { location},
	},
	winbar = {
		lualine_a = { buffers },
		lualine_b = {
            { navic.get_location, cond = navic.is_available },
        }
	},
	extensions = { "toggleterm" },
})
