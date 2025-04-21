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

---Identify if a package is an LSP
---@param pkg Package Mason package to check
---@return boolean
local function is_package_lsp(pkg)
	local res = false
	for _, value in ipairs(pkg.spec.categories) do
		res = res or (value == "LSP")
	end
	return res
end

local registry = require("mason-registry")
local server_mappings = require("mason-lspconfig.mappings.server")
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
	if is_package_lsp(pkg) then
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
				{ "gl", luacmd(vim.diagnostic.open_float), desc = "Diagnostic Float", options },
				{ "<leader>lq", luacmd(vim.diagnostic.setloclist), desc = "Quickfix" },
				{ "<leader>lj", luacmd(vim.diagnostic.jump, { count = 1, float = true }), desc = "Next Diagnostic" },
				{ "<leader>lk", luacmd(vim.diagnostic.jump, { count = -1, float = true }), desc = "Prev Diagnostic" },
			})
		end
		if client:supports_method("textDocument/formatting") then
			wk.add({
				"<leader>lf",
				luacmd(require("conform").format, {
					lsp_fallback = true,
					async = true,
					timeout_ms = 500,
				}),
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
