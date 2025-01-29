-- https://luals.github.io/wiki/settings/
return {
	settings = {
		Lua = {
			completion = { callSnippet = "Both", displayContext = 5, keywordSnippet = "Both" },
			format = {
				enable = false,
				-- defaultConfig = require("lspsettings/lua_format"),
			},
			dagnostics = {
				globals = { "vim", "wk", "spec" },
				-- globals = { "vim", "spec" },
			},
			runtime = {
				version = "LuaJIT",
				-- special = {
				--   spec = "require",
				-- },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.api.nvim_get_runtime_file("", true),
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
			hint = {
				enable = true,
				arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
				await = true,
				paramName = "All", -- "All" | "Literal" | "Disable"
				paramType = false,
				semicolon = "Disable", -- "All" | "SameLine" | "Disable"
				setType = false,
			},
			telemetry = { enable = false },
		},
	},
}
