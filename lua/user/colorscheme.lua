local colorscheme = 'darkplus'
-- local colorscheme = 'hackthebox'
-- local colorscheme = 'tokyonight-night'

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
		vim.notify("Colorscheme " .. colorscheme .. " not found!", "warn")
	return
end
