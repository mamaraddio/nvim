local servers = {
	"lua_ls",
	"vimls",
}
local function generate_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	local require_ok, blink_cmp = pcall(require, "blink_cmp")
	if require_ok then
		capabilities = blink_cmp.get_lsp_capabilities(capabilities)
	end
	return capabilities
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"folke/neodev.nvim",
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = servers,
			},
			dependencies = {
				"mason.nvim",
				opts = {
					ui = {
						border = "rounded",
					},
				},
			},
		},
	},
	init = function()
		wk.add({
			{ "<leader>l", group = "LSP" },
			{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>lf", luacmd(vim.lsp.buf.format, { async = true }), desc = "Format" }, --[[ filter = function(client) return client.name ~= 'typescript-tools' end ]]
			{
				"<leader>lh",
				function()
					local bufnr = vim.api.nvim_get_current_buf()
					local hint = vim.lsp.inlay_hint
					hint.enable(not hint.is_enabled({ bufnr }), { bufnr })
				end,
				desc = "Toggle Hints",
			},
			{ "<leader>li", vim.cmd.LspInfo, desc = "LSP Info" },
			{ "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
			{ "<leader>lk", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
			{ "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
			{ "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
			{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
		})
	end,
	config = function()
		local lspconfig = require("lspconfig")
		local icons = require("config.icons").diagnostics

		vim.diagnostic.config({
			signs = {
				active = true,
				values = {
					{ name = "DiagnosticSignError", text = icons.Error },
					{ name = "DiagnosticSignWarn", text = icons.Warning },
					{ name = "DiagnosticSignHint", text = icons.Hint },
					{ name = "DiagnosticSignInfo", text = icons.Information },
				},
			},
			virtual_text = false,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				---@type string
				source = "always",
				header = "",
				prefix = "",
			},
		})

		---@diagnostic disable-next-line: param-type-mismatch
		for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
		end

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		require("lspconfig.ui.windows").default_options.border = "rounded"

		for _, server in pairs(servers) do
			local opts = {
				on_attach = function(client, bufnr)
					local options = { noremap = true, silent = true, buffer = bufnr }
					wk.add({ "gd", vim.lsp.buf.definition, desc = "Goto Definition" , options})
					wk.add({ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" , options})
					wk.add({ "K", vim.lsp.buf.hover, desc = "Hover Definition" , options})
					wk.add({ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" , options})
					wk.add({ "gr", vim.lsp.buf.references, desc = "Goto References" , options})
					wk.add({ "gl", vim.diagnostic.open_float, desc = "Diagnostic Float" , options})

					if client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr })
					end
				end,
				capabilities = generate_capabilities(),
			}

			local require_ok, settings = pcall(require, "lspsettings." .. server)
			if require_ok then
				opts = vim.tbl_deep_extend("force", settings, opts)
			end

			if server == "lua_ls" then
				require("neodev").setup()
			end

			lspconfig[server].setup(opts)
		end
	end,
}
