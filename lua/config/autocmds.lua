vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"netrw",
		"Jaq",
		"qf",
		"git",
		"help",
		"man",
		"lspinfo",
		"oil",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"",
	},
	callback = function()
		vim.keymap.set("n", "q", vim.cmd.close, { noremap = true, silent = true, buffer = true })
		vim.opt.buflisted = false
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function() vim.cmd.quit() end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function() vim.cmd.tabdo("wincmd =") end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "!vim" },
	callback = function() vim.cmd.checktime() end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 40 }) end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then return end
		if luasnip.expand_or_jumpable() then
			-- ask maintainer for option to make this silent
			-- luasnip.unlink_current()
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})