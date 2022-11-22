local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	-- separator = "  ",
	-- separator = " > ",
	separator = "  ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = true,
})

vim.api.nvim_set_hl(0, "NavicIconsFile",          { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsModule",        { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace",     { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsPackage",       { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsClass",         { default = true, bg = "#1E1E1E", fg = "#E8AB53" })
vim.api.nvim_set_hl(0, "NavicIconsMethod",        { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsProperty",      { default = true, bg = "#1E1E1E", fg = "#6a9955" })
vim.api.nvim_set_hl(0, "NavicIconsField",         { default = true, bg = "#1E1E1E", fg = "#6a9955" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor",   { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsEnum",          { default = true, bg = "#1E1E1E", fg = "#6a9955" })
vim.api.nvim_set_hl(0, "NavicIconsInterface",     { default = true, bg = "#1E1E1E", fg = "#E8AB53" })
vim.api.nvim_set_hl(0, "NavicIconsFunction",      { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsVariable",      { default = true, bg = "#1E1E1E", fg = "#c586c0" })
vim.api.nvim_set_hl(0, "NavicIconsConstant",      { default = true, bg = "#1E1E1E", fg = "#ce9178" })
vim.api.nvim_set_hl(0, "NavicIconsString",        { default = true, bg = "#1E1E1E", fg = "#6a9955" })
vim.api.nvim_set_hl(0, "NavicIconsNumber",        { default = true, bg = "#1E1E1E", fg = "#ce9178" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean",       { default = true, bg = "#1E1E1E", fg = "#ce9178" })
vim.api.nvim_set_hl(0, "NavicIconsArray",         { default = true, bg = "#1E1E1E", fg = "#ce9178" })
vim.api.nvim_set_hl(0, "NavicIconsObject",        { default = true, bg = "#1E1E1E", fg = "#ce9178" })
vim.api.nvim_set_hl(0, "NavicIconsKey",           { default = true, bg = "#1E1E1E", fg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "NavicIconsNull",          { default = true, bg = "#1E1E1E", fg = "#ce9178" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    { default = true, bg = "#1E1E1E", fg = "#D16969" })
vim.api.nvim_set_hl(0, "NavicIconsStruct",        { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsEvent",         { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicIconsOperator",      { default = true, bg = "#1E1E1E", fg = "#42A5F5" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#1E1E1E", fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NavicText",               { default = true, bg = "#1E1E1E", fg = "#BAC2DE" })
vim.api.nvim_set_hl(0, "NavicSeparator",          { default = true, bg = "#1E1E1E", fg = "#D16969" })
