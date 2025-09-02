local luacmd = require("utils").luacmd
local wk = require("which-key")
local diagnostics_icons = require("config.icons").diagnostics
vim.diagnostic.config({
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostics_icons.Error,
			[vim.diagnostic.severity.WARN] = diagnostics_icons.Warning,
			[vim.diagnostic.severity.INFO] = diagnostics_icons.Hint,
			[vim.diagnostic.severity.HINT] = diagnostics_icons.Information,
		},
	},
	virtual_lines = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		---@type string
		source = "if_many",
		header = "",
		prefix = "",
	},
})

local registry = require("mason-registry")
local server_mappings = require("mason-lspconfig").get_mappings()
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
	root_markers = { ".git" },
})
for _, pkg in pairs(registry.get_installed_packages()) do
	if vim.list_contains(pkg.spec.categories, "LSP") then
		local server = server_mappings.package_to_lspconfig[pkg.name]
		local require_ok, settings = pcall(require, "lspsettings." .. server)
		if require_ok then vim.lsp.config(server, settings) end
		vim.lsp.enable(server)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LSP", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local options = { noremap = true, silent = true, buffer = args.buf }

		wk.add({
			{ "<leader>l", group = "LSP" },
			{ "<leader>li", luacmd(vim.cmd.checkhealth, "vim.lsp"), desc = "LSP Info" },
			{ "<leader>ll", luacmd(vim.lsp.codelens.run), desc = "CodeLens Action" },
		})

		if client:supports_method("textDocument/foldingRange", args.buf) then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end

		if client:supports_method("textDocument/inlayHint", args.buf) then
			vim.lsp.inlay_hint.enable(true, { args.buf })
		end
		if client:supports_method("workspace/inlayHint") then vim.lsp.inlay_hint.enable(true) end
		if client:supports_method("textDocument/definition", args.buf) then
			wk.add({ "gd", vim.lsp.buf.definition, desc = "Goto Definition", options })
		end
		if client:supports_method("textDocument/declaration", args.buf) then
			wk.add({ "gD", luacmd(vim.lsp.buf.declaration), desc = "Goto Declaration", options })
		end
		if client:supports_method("textDocument/hover", args.buf) then
			wk.add({
				"K",
				luacmd(vim.lsp.buf.hover),
				desc = "Hover Definition",
				options,
			})
		end
		if client:supports_method("textDocument/implementation", args.buf) then
			wk.add({ "gI", luacmd(vim.lsp.buf.implementation), desc = "Goto Implementation", options })
		end
		if client:supports_method("textDocument/references", args.buf) then
			wk.add({ "gr", luacmd(vim.lsp.buf.references), desc = "Goto References", options })
		end
		if client:supports_method("textDocument/documentSymbol", args.buf) then
			wk.add({ "gs", luacmd(vim.lsp.buf.document_symbol), desc = "Goto Symbol", options })
		end
		if client:supports_method("workspace/symbol", args.buf) then
			wk.add({ "gS", luacmd(vim.lsp.buf.workspace_symbol), desc = "Goto Workspace Symbol", options })
		end
		if client:supports_method("textDocument/diagnostics") then
			wk.add({
				{
					"gl",
					luacmd(vim.diagnostic.open_float),
					desc = "Diagnostic Float",
					options,
				},
				{ "<leader>lq", luacmd(vim.diagnostic.setloclist), desc = "Quickfix" },
				{ "<leader>lj", luacmd(vim.diagnostic.jump, { count = 1, float = true }), desc = "Next Diagnostic" },
				{ "<leader>lk", luacmd(vim.diagnostic.jump, { count = -1, float = true }), desc = "Prev Diagnostic" },
			})
		end
		if client:supports_method("textDocument/formatting") then
			wk.add({
				"<leader>lf",
				luacmd(require("conform").format),
				desc = "Format file or range (in visual mode)",
				options,
			})
		end
		if client:supports_method("textDocument/codeAction") then
			wk.add({ "<leader>la", luacmd(vim.lsp.buf.code_action), desc = "Code Action", options })
		end
		if client:supports_method("textDocument/rename") then
			wk.add({ "<leader>lr", luacmd(vim.lsp.buf.rename), desc = "Rename", options })
		end
	end,
})
