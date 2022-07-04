local colorscheme = 'hackthebox'

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
		vim.notify("Colorscheme " .. colorscheme .. " not found!", "warn")
	return
end
